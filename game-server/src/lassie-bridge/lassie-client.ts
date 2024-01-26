import { keys, map, max } from 'lodash';
import Lassie from './lassie-api';
import { handleLassieCheckinsPersons, handleLassieCheckinsTotals, handleLassieGenerationTransactions } from './lassie-state';
import { LassieCheckinsPersonsData, LassieCheckinsTotalsData, LassieGenerationTransactionsData, LassiePollerId, LassiePollerTimeouts } from './types';

import { LASSIE_CHECKIN_PERSONS_POLLING_INTERVAL, LASSIE_CHECKIN_TOTALS_POLLING_INTERVAL, LASSIE_TRANSACTION_POLLING_INTERVAL } from './utilities/constants';
import environment from './utilities/environment';
import logger from './utilities/logger';

const {
  LASSIE_API_HOST_NAME,
  LASSIE_API_KEY,
  LASSIE_API_SECRET,
  LASSIE_API_LOGGING,
  LASSIE_START_BAR_TRANSACTION_ID,
  LASSIE_CHECKIN_EVENT_ID,
} = environment.env;

let lassieClient: any = null;
let lastTransactionId = LASSIE_START_BAR_TRANSACTION_ID;
let pollerTimeouts: LassiePollerTimeouts = {
  transactions: undefined,
  checkinPersons: undefined,
  checkinTotals: undefined,
};

/**
 * Initialize the Lassie client and its polling mechanism.
 */
export async function initializeLassieClient() {
  await initializeLassieInstance();
  await initializeLassiePollers();
}

export async function destructLassie() {
  map(pollerTimeouts, (value) => {
    clearTimeout(value);
  })
}

function initializeLassieInstance() {
  console.info('Authenticating to the Lassie API...');
  lassieClient = new Lassie.Instance(
    LASSIE_API_HOST_NAME,
    LASSIE_API_KEY,
    LASSIE_API_SECRET,
    LASSIE_API_LOGGING,
  );

  return new Promise<void>((resolve, reject) => {
    lassieClient.validate((valid: boolean) => {
      if (!valid) {
        reject('The Lassie API credentials are not valid!');
      } else {
        logger.info('The Lassie API successfully authenticated.');
        resolve();
      }
    });
  });
}

/**
 * Initialize the polling mechanism requesting new transactions from Lassie.
 * Note that his poller is blocking and will not hoard requests when Lassie is taking
 * too long to respond.
 */
function initializeLassiePollers() {
  logger.info('Initializing the Lassie pollers...');

  initializeBlockingPoller('transactions', LASSIE_TRANSACTION_POLLING_INTERVAL, () => {
    // return new Promise((resolve) => resolve());
    return new Promise<void>((resolve, reject) => {
      logger.info(`Fetching transactions from ${LASSIE_API_HOST_NAME}...`);
      Lassie.Model.TransactionModel.getNewGenerationTransactions(lassieClient, {
        module_name: 'bar',
        last_transaction_id: lastTransactionId,
      }, (error: any, result: any) => {
        const data: LassieGenerationTransactionsData = result?.data ?? {};

        if (error) {
          reject(error);
          return;
        }

        handleLassieGenerationTransactions(data);
        updateLastTransactionId(data);
        resolve();
      });
    });
  });

  initializeBlockingPoller('checkinPersons', LASSIE_CHECKIN_PERSONS_POLLING_INTERVAL, () => {
    // return new Promise((resolve) => resolve());
    return new Promise((resolve, reject) => {
      logger.info(`Fetching checkin persons from ${LASSIE_API_HOST_NAME}...`);
      Lassie.Model.EventModel.GetCheckinsByEventId(lassieClient, {
        event_id: LASSIE_CHECKIN_EVENT_ID,
        start_id: 0,
      }, (error: any, result: any) => {
        const data: LassieCheckinsPersonsData = result?.data ?? {};

        if (error) {
          reject(error);
          return;
        }

        handleLassieCheckinsPersons(data);
        resolve();
      });
    });
  });

  initializeBlockingPoller('checkinTotals', LASSIE_CHECKIN_TOTALS_POLLING_INTERVAL, () => {
    // return new Promise((resolve) => resolve());
    return new Promise((resolve, reject) => {
      logger.info(`Fetching checkin totals from ${LASSIE_API_HOST_NAME}...`);
      Lassie.Model.EventModel.GetGenerationCheckinsByEventId(lassieClient, {
        event_id: LASSIE_CHECKIN_EVENT_ID,
        start_id: 0,
      }, (error: any, result: any) => {
        const data: LassieCheckinsTotalsData = result?.data ?? {};

        if (error) {
          reject(error);
          return;
        }

        handleLassieCheckinsTotals(data);
        resolve();
      });
    });
  });
}

function updateLastTransactionId(data: LassieGenerationTransactionsData) {
  const ids = map(keys(data), (stringifiedId) => {
    return parseInt(stringifiedId);
  });
  const maxId = max(ids);

  // guard: check if no max ID was found
  if (!maxId) {
    return;
  }

  lastTransactionId = maxId;
  logger.info(`The new last transaction ID was changed to: ${lastTransactionId}`);
}

/**
 * Initialize a single blocking poller that will not execute until the callback is done.
 */
function initializeBlockingPoller(id: LassiePollerId, delay: number, callback: () => Promise<void>) {
  const executeCallback = () => {
    callback().then(() => {
      logger.verbose(`Refetched Lassie poller for ID: ${id}`);
      queuePollTimeout();
    }).catch((error) => {
      logger.verbose(`Errored Lassie poller for ID: ${id}`);
      logger.verbose(error);
      queuePollTimeout();
    });
  };
  const queuePollTimeout = () => {
    pollerTimeouts[id] = setTimeout(() => {
      logger.verbose(`Fetching Lassie poller for ID: ${id}...`);
      executeCallback();
    }, delay);
  };

  // spin up the first request immediately without delay
  executeCallback();
}
