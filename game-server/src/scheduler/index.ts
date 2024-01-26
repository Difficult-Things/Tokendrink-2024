import { SetCurrentLaunch, SetCurrentPhase } from '../../../specifications/StateInput';
import { connectToMqttServer } from './mqtt-client'
import { TIMELINE } from './timeline'
import TimelineManager from './TimelineManager'

const MQTT_TOPIC = '/state/input';

async function main() {
  const client = await connectToMqttServer();

  const timeline = new TimelineManager(TIMELINE)
  timeline.registerHandler(
    entry => {
      console.log(`${entry.id} started, outputting message`);
      const phaseMessage: SetCurrentPhase = {
        name: 'setCurrentPhase',
        payload: {
          phase: entry.phase,
        }
      }
      const launchMessage: SetCurrentLaunch = {
        name: 'setCurrentLaunch',
        payload: {
          launch: entry.launch,
        }
      }
      client.publish(MQTT_TOPIC, JSON.stringify(phaseMessage));
      client.publish(MQTT_TOPIC, JSON.stringify(launchMessage));
    },
    entry => console.log(`${entry.id} ended`)
  )
  timeline.print()
  timeline.progress(1000)
  timeline.start()
}

main();
