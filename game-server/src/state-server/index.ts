import { State } from '../../../specifications/StateOutput'
import { DEFAULT_GAME_STATE, STATE_UPDATE_RATE, STORE } from './config'
import GameState from './GameState'
import GameStateManager from './GameStateManager'
import { connectToMqttServer, MQTT_OUTPUT_TOPIC, subscribeToMqtt } from './mqtt-client'

const state = new GameState({
  log: false,
})

const start = async () => {
  await state.loadStore(STORE)
}

(async () => {
  console.log('[STATE-SERVER]', 'Starting state-server...');
  await start()
  console.log('[STATE-SERVER]', 'Store loaded.');

  // Connect to the MQTT server
  console.log('[STATE-SERVER]', 'Connecting to MQTT broker...');
  const client = await connectToMqttServer();
  console.log('[STATE-SERVER]', 'Succesfully connected to MQTT broker.');

  console.log('[STATE-SERVER]', 'Registering handlers...');
  
  const manager = new GameStateManager(state)

  const sendState = () => {
    client.publish(MQTT_OUTPUT_TOPIC, JSON.stringify(manager.getState()))
  }

  // Send an update on MQTT every time the state changes
  state.on('update', sendState);

  // Listen for incoming events
  subscribeToMqtt(client, (event) => {
    console.log('[STATE-SERVER]', 'Received message:', event?.name, event);
    switch (event?.name) {
      case 'retrieveState':
        sendState()
        break;
      case 'setCurrentPhase':
        manager.setPhase(event.payload.phase)
        break;
      case 'setGameState':
        manager.setState(event.payload)
        break;
      case 'setDefaultGameState':
        manager.setState(DEFAULT_GAME_STATE)
        break;
      case 'adjustScore':
        manager.setScore(event.payload);
        break;
      case 'adjustGlobalMultiplier':
        manager.setGlobalMultiplier(event.payload.globalMultiplier);
        break;
      case 'adjustSodaMultiplier':
        manager.setSodaMultiplier(event.payload.sodaMultiplier);
        break;
      case 'adjustTeamMultiplier':
        manager.setTeamMultipliers(event.payload);
        break;
      case 'setCurrentLaunch':
        manager.setLaunch(event.payload.launch);
        break;
      case 'setRocketMapping':
        manager.setRocketMapping(event.payload);
        break;
      case 'lassieGlobal':
        manager.handleLassieGlobal(event);
        break;
      case 'setOldestMember':
        manager.state.set('oldestMember', event.payload);
      default:
        console.error(`Found event without handler: ${event?.name}`);
        break;
    }
  });

  setInterval(sendState, STATE_UPDATE_RATE)

  console.log('[STATE-SERVER]', 'All handlers successfully registered. Server is now ready!');
})()
