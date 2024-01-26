import mqtt, { MqttClient } from 'mqtt';
import { TEST_TOPIC, ONE_SECOND } from './utilities/constants';

import logger from './utilities/logger';
import environment from './utilities/environment';
import { MqttMessageCallback } from './types';
import { MQTT_PASSWORD, MQTT_USERNAME } from '../../../specifications/Common';

const {
  MQTT_HOST_NAME,
} = environment.env;

let mqttClient: MqttClient = mqtt.connect(MQTT_HOST_NAME);

export async function initializeMqtt() {
  await initializeMqttClient();
  await testMqttServer();
}

export async function destructMqtt() {
  mqttClient.end();
}

export async function subscribeToMqtt<T>(topic: string, callback: MqttMessageCallback<T>) {
  return new Promise<void>((resolve, reject) => {
    mqttClient.subscribe(topic, { qos: 2 }, (error) => {
      if (error) {
        reject(error);
        return;
      }

      resolve();
      mqttClient.on('message', (receivedTopic, receivedMessage) => {

        // guard: check if the topic matches
        // TODO: if needed, add support for wildcards!
        if (topic !== receivedTopic) {
          return;
        }

        try {
          const parsedMessage = JSON.parse(receivedMessage.toString());
          callback(receivedTopic, parsedMessage);
        } catch (error) {
          logger.error('Could not parse MQTT message:');
          logger.error(receivedMessage);
        }
      });
    });
  })
}

export async function publishToMqtt(topic: string, message: object) {
  const stringifiedMessage = JSON.stringify(message);

  return new Promise<void>((resolve, reject) => {
    mqttClient.publish(topic, stringifiedMessage, { qos: 2 }, (error) => {
      if (error) {
        logger.error('An error occured when sending the MQTT message:');
        logger.error(error);
      }

      resolve();
    });
  });
};

async function initializeMqttClient() {
  logger.info('Initializing the MQTT client...');

  // initialize to new instance
  mqttClient = mqtt.connect(MQTT_HOST_NAME, { username: MQTT_USERNAME, password: MQTT_PASSWORD });

  // resolve when connected
  return new Promise<void>((resolve, reject) => {

    // add an MQTT connection timeout
    const mqttTimeout = setTimeout(() => {
      reject('Could not connect to the MQTT endpoint');
    }, ONE_SECOND * 10);

    // add message debugger
    mqttClient.on('message', (topic, message) => {
      logger.verbose('A new MQTT message is received on topic: ', topic);
    });

    // wait for connect to resolve
    mqttClient.on('connect', () => {
      logger.info('The MQTT client is successfully connected!');
      clearTimeout(mqttTimeout);
      resolve();
    });
  });
}

async function testMqttServer() {
  await subscribeToMqtt(TEST_TOPIC, (_topic, _message) => {
    logger.info('The MQTT server is working properly, because the test message was received!');
  });
  await publishToMqtt(TEST_TOPIC, { test: true });
}
