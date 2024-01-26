import mqtt, { Client } from 'mqtt';
import { MQTT_PASSWORD, MQTT_USERNAME } from '../../../specifications/Common';
import { LassieInputEvent } from '../../../specifications/LassieInput';
import { LassieOutputEvent } from '../../../specifications/LassieOutput';
import { StateInputEvent } from '../../../specifications/StateInput';

const MQTT_HOST = 'localhost';
const MQTT_PORT = 1883;

/**
 * Connect to a MQTT client and return the client
 */
export function connectToMqttServer(): Promise<Client> {
    return new Promise((resolve, reject) => {
        const client = mqtt.connect(`mqtt://${MQTT_HOST}:${MQTT_PORT}`, { username: MQTT_USERNAME, password: MQTT_PASSWORD });

        client.on('connect', function () {
            resolve(client);
        });
    });
}
