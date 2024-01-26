import * as dotenv from 'dotenv';
import path from 'path';

// load .env file into process.env
dotenv.config({
  path: path.join(__dirname, '.env'),
});

console.log(path.join(__dirname))
import { initializeApi } from './api-server';
import { destructLassie, initializeLassieClient } from './lassie-client';
import { initializeLassieState } from './lassie-state';
import { destructMqtt, initializeMqtt } from './mqtt-client';
import logger from './utilities/logger';

/**
 * Starting the Lassie Bridge.
 */
async function start() {
  logger.info('Starting Lassie Bridge...');
  await initializeLassieState();
  await initializeMqtt();
  await initializeLassieClient();
  await initializeApi();
  logger.info('The Lassie Bridge is successfully booted up!');
  logger.info('Listening to new events...');
}

/**
 * Stopping the Lassie Bridge.
 */
async function stop() {
  logger.info('Stopping Lassie Bridge...');
  await destructMqtt();
  await destructLassie();
  logger.info('The Lassie Bridge is successfully stopped!');
  process.exit(0);
}

// starting main thread
(async () => {
  try {
    await start();
  } catch (error) {
    logger.error('An error occured when starting the Lassie bridge:');
    logger.error(error);
    stop();
    process.exit(1);
  }
})();

// handle end signals for graceful shutdown
process.on('SIGINT', () => {
  logger.info(`Stopping process due to SIGINT...`);
  stop();
});
