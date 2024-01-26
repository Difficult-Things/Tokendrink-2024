import dayjs from 'dayjs';
import { includes, isEqual, map, size, toLower } from 'lodash';

import { CheckinsLassieEvent, LassieState } from '../../../specifications/LassieOutput';
import { sendGlobalLassieEvent, sendLassieCheckinsEvent } from './api-server';

import { ExtendedLassieState, LassieCheckinsPersonsData, LassieCheckinsTotalsData, LassieGenerationTransactionsData } from './types';
import { BEER_IDENTIFIERS, BEER_NAME_IDENTIIERS, getTeamColorByGeneration } from './utilities/constants';
import logger from './utilities/logger';

export interface CalculateTeamTotalOptions {
  fromPeriod: string;
  toPeriod: string;
}

/**
 * Store for all the raw lassie transactions and checkins
 */
let lassieTransactions: LassieGenerationTransactionsData = {};
let lassieCheckinsPersons: LassieCheckinsPersonsData = {};
let lassieCheckinsTotals: LassieCheckinsTotalsData = {};

export async function initializeLassieState() {
  loadLassieTransactions();
}

export function handleLassieGenerationTransactions(newLassieTransactions: LassieGenerationTransactionsData) {

  // guard: check if there are any new transactions
  if (size(newLassieTransactions) <= 0) {
    logger.verbose(`No new Lassie transactions were found.`);
    return;
  }

  // merge into the new object with IDs as the key
  lassieTransactions = {
    ...lassieTransactions,
    ...newLassieTransactions,
  };

  logger.info(`There are now ${size(lassieTransactions)} Lassie transactions.`);
  saveLassieTransactions();
  sendGlobalLassieEvent();
}

export function handleLassieCheckinsTotals(data: LassieCheckinsTotalsData) {
  const previousLassieCheckinsTotals = lassieCheckinsTotals;
  lassieCheckinsTotals = data;

  // check for any changes and update if so
  if (!isEqual(previousLassieCheckinsTotals, data)) {
    logger.info(`Pro-actively sending out checkins because there was a change in the totals...`);
    logger.info('The checkin totals are now:')
    logger.info(data);
    sendLassieCheckinsEvent();
  }
}

export function handleLassieCheckinsPersons(data: LassieCheckinsPersonsData) {
  const previousLassieCheckinsPersons = lassieCheckinsPersons;
  lassieCheckinsPersons = data;

  // check for any changes and update if so
  if (!isEqual(previousLassieCheckinsPersons, data)) {
    logger.info(`Pro-actively sending out checkins because there was a change in the persons...`);
    logger.info(`There are now ${size(lassieCheckinsPersons)} checkins.`);
    sendLassieCheckinsEvent();
  }
}

// TODO: consider adding caching
export function calculateTeamTotals(options?: CalculateTeamTotalOptions): ExtendedLassieState {
  const lassieState = generateEmptyLassieState();
  const fromPeriodDate = dayjs(options?.fromPeriod);
  const toPeriodDate = dayjs(options?.toPeriod);

  // loop all Lassie transactions
  map(lassieTransactions, (lassieTransaction) => {
    const generationId = lassieTransaction.generation_id;
    const productName = lassieTransaction.product_id;
    const productId = parseInt(lassieTransaction.__product_id);
    const transactionAt = lassieTransaction.create_timestamp;
    const transactionDate = dayjs(transactionAt);
    const quantity = parseInt(lassieTransaction.quantity);
    const teamColor = getTeamColorByGeneration(generationId);
    const isSingleDrinkOrder = (quantity === 1);

    const isBeerByName = includes(map(BEER_NAME_IDENTIIERS, (nameIdentifier) => {
      return includes(toLower(productName), toLower(nameIdentifier));
    }), true);
    const isBeerById = includes(BEER_IDENTIFIERS, productId);
    const isBeer = isBeerByName || isBeerById;

    // guard: skip when invalid generation ID
    if (!teamColor) {
      return;
    }

    // guard: skip when outside of requested period, if any were set
    if (options && (transactionDate.isBefore(fromPeriodDate) || transactionDate.isAfter(toPeriodDate))) {
      return;
    }

    // add to beer or soda
    if (isBeer) {
      lassieState.beer[teamColor] += quantity;
    } else {
      lassieState.soda[teamColor] += quantity;
    }

    // add to single drink order
    if (isSingleDrinkOrder && lassieState.singleDrinkOrders) {
      lassieState.singleDrinkOrders[teamColor] += 1;
    }
  });

  logger.info('The lassie state was updated to:');
  logger.info(lassieState);

  return lassieState;
}

export function calculateCheckinsPerColor() {
  const perColor: CheckinsLassieEvent['perColor'] = {
    blue: 0,
    green: 0,
    orange: 0,
    purple: 0,
    red: 0,
  };

  // loop all checkin total per generation and classify them to specific colors
  map(lassieCheckinsTotals, (total, generationId) => {
    const teamColor = getTeamColorByGeneration(generationId);

    // guard: skip if no team color
    if (!teamColor) {
      return;
    }

    perColor[teamColor] += total;
  });

  return perColor;
}

export function calculateCheckinsPerGeneration() {
  const perGeneration: CheckinsLassieEvent['perGeneration'] = {};

  // map the total directly to generations that are converted to proper numeric values
  map(lassieCheckinsTotals, (total, generationId) => {
    perGeneration[String(generationId)] = total;
  });

  return perGeneration;
}

/**
 * Load the persistent lassie transactions
 */
function loadLassieTransactions() {
  // TODO
}

/**
 * Save the current lassie transactions to the file system
 */
function saveLassieTransactions() {
  // TODO
}

function generateEmptyLassieState() {
  const lassieState: ExtendedLassieState = {
    beer: {
      blue: 0,
      green: 0,
      orange: 0,
      purple: 0,
      red: 0,
    },
    soda: {
      blue: 0,
      green: 0,
      orange: 0,
      purple: 0,
      red: 0,
    },
    singleDrinkOrders: {
      blue: 0,
      green: 0,
      orange: 0,
      purple: 0,
      red: 0,
    },
  };

  return lassieState;
}
