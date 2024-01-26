import { LassieInputEvent } from '../../../specifications/LassieInput';
import { CheckinsLassieEvent, GlobalLassieEvent, PeriodLassieEvent } from '../../../specifications/LassieOutput';
import { calculateCheckinsPerColor, calculateCheckinsPerGeneration, calculateTeamTotals } from './lassie-state';
import { publishToMqtt, subscribeToMqtt } from './mqtt-client';
import { INPUT_TOPIC, OUTPUT_TOPIC } from './utilities/constants';
import logger from './utilities/logger';

export async function initializeApi() {
  logger.info('Initializing API to respond to MQTT requests...');

  // handle requests for all drinks
  subscribeToMqtt<LassieInputEvent>(INPUT_TOPIC, (_topic, message) => {
    logger.info(`Received new MQTT event on the input channel with message:`);
    logger.info(message);
    const messageName = message.name;
    logger.info(`Received MQTT input request: ${messageName}...`);

    // check which input request was received
    switch (messageName) {
      case 'retrieveDrinks':
        sendGlobalLassieEvent();
        break;
      case'retrieveDrinksForSpecificPeriod':
        const fromPeriod = message?.payload?.start;
        const toPeriod = message?.payload?.end;
        const periodState = calculateTeamTotals({
          fromPeriod,
          toPeriod,
        });
        const periodMessage: PeriodLassieEvent = {
          name: 'lassiePeriod',
          state: {
            beer: periodState.beer,
            soda: periodState.soda,
          },
          id: message?.payload?.id,
          from: fromPeriod,
          to: toPeriod,
        };
        publishToMqtt(OUTPUT_TOPIC, periodMessage);
        break;
      case 'retrieveCheckins':
        sendLassieCheckinsEvent();
        break;
    }
  });

  logger.info('Initialized API successfully!');
}

export function sendGlobalLassieEvent() {
  const globalState = calculateTeamTotals();
  const globalMessage: GlobalLassieEvent = {
    name: 'lassieGlobal',
    state: {
      beer: globalState.beer,
      soda: globalState.soda,
    },
    singleDrinkOrders: globalState.singleDrinkOrders,
  };
  publishToMqtt(OUTPUT_TOPIC, globalMessage);
}

export function sendLassieCheckinsEvent() {
  const checkinsMessage: CheckinsLassieEvent = {
    name: 'lassieCheckins',
    perColor: calculateCheckinsPerColor(),
    perGeneration: calculateCheckinsPerGeneration(),
  };
  publishToMqtt(OUTPUT_TOPIC, checkinsMessage);
}
