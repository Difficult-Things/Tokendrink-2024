import Aedes from 'aedes';
import { MQTT_PASSWORD, MQTT_USERNAME } from '../../../specifications/Common';
const aedes = new Aedes();
const server = require('net').createServer(aedes.handle)
const httpServer = require('http').createServer()
const ws = require('websocket-stream')
const mqttPort = 1883
const websocketPort = 8888

const authorizedClients = new Set();

aedes.authenticate = (client, username, password, callback) => {
  if (username === MQTT_USERNAME && password.toString('utf-8') === MQTT_PASSWORD) {
    authorizedClients.add(client.id);
  }

  callback(null, true);
}

aedes.authorizePublish = (client, packet, callback) => {
  if (client && authorizedClients.has(client.id)) {
    callback(null);
  } else {
    callback(new Error('Unauthorized for publishing'));
  }
}

aedes.on('subscribe', function (subscriptions, client) {
    console.log('MQTT client :' + (client ? client.id : client) +
            ' subscribed to topics: ' + subscriptions.map(s => s.topic).join('\n'), 'from broker', aedes.id)
  })

  aedes.on('unsubscribe', function (subscriptions, client) {
    console.log('MQTT client :' + (client ? client.id : client) +
            ' unsubscribed to topics: ' + subscriptions.join('\n'), 'from broker', aedes.id)
  })

  // fired when a client connects
  aedes.on('client', function (client) {
    console.log('Client Connected: ' + (client ? client.id : client) + ' ', 'to broker', aedes.id)
  })

  // fired when a client disconnects
  aedes.on('clientDisconnect', function (client) {
    console.log('Client Disconnected: ' + (client ? client.id : client) + ' ', 'to broker', aedes.id)
    authorizedClients.delete(client.id);
  })

  // fired when a message is published
  aedes.on('publish', async function (packet, client) {
    console.log('Client :' + (client ? client.id : 'BROKER_' + aedes.id) + ' has published ', packet.payload.toString(), ' on ', packet.topic, ' to broker', aedes.id)
  })

server.listen(mqttPort, function () {
    console.log('MQTT server started and listening on port ', mqttPort)
})
ws.createServer({ server: httpServer }, aedes.handle)

httpServer.listen(websocketPort, function () {
    console.log('websocket server listening on port ', websocketPort)
})
