import mqtt, { Client } from 'mqtt';
import { MQTT_PASSWORD, MQTT_USERNAME } from '../../../specifications/Common';
import { LassieInputEvent } from '../../../specifications/LassieInput';
import { LassieOutputEvent } from '../../../specifications/LassieOutput';
import { StateInputEvent } from '../../../specifications/StateInput';

const MQTT_HOST = 'localhost';
const MQTT_PORT = 1883;
const MQTT_INPUT_TOPIC = '/state/input';
const MQTT_LASSIE_INPUT_TOPIC  = '/lassie/input';
const MQTT_LASSIE_OUTPUT_TOPIC  = '/lassie/output';
export const MQTT_OUTPUT_TOPIC = '/state/output';

/**
 * Connect to a MQTT client and return the client
 */
export function connectToMqttServer(): Promise<Client> {
    return new Promise((resolve, reject) => {
        const client = mqtt.connect(`mqtt://${MQTT_HOST}:${MQTT_PORT}`, { username: MQTT_USERNAME, password: MQTT_PASSWORD });

        client.on('connect', function () {
            client.subscribe([MQTT_INPUT_TOPIC, MQTT_LASSIE_OUTPUT_TOPIC], (err) => {
                if (err) {
                    reject(err);
                }

                resolve(client);
            });
        });
    });
}

/** 
 * Subscribe to the MQTT topic and parse the incoming message
 */
export function subscribeToMqtt(client: Client, callback: (event: StateInputEvent | LassieOutputEvent) => void): void {
    client.on('message', (topic, payload) => {
        if (topic !== MQTT_INPUT_TOPIC && topic !== MQTT_LASSIE_OUTPUT_TOPIC) {
            return;
        }

        // Parse payload as string and parse string to JSON
        try {
            const message = JSON.parse(payload.toString('utf8'));

            // Then return the message to the calling function
            callback(message as StateInputEvent);
        } catch (e) {
            console.error('error while parsing MQTT message', e, payload.toString('utf8'));
        }
    });
}