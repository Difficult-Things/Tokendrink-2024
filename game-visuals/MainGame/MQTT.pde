import mqtt.*;
MQTTClient client;

void setupMQTT() {
  client = new MQTTClient(this);
  client.setWill(statusTopic, "OFFLINE", 2, true);
  client.connect(serverIP, uuid);
}


void clientConnected() {
  println("client connected");
  client.publish(statusTopic, "ONLINE");

  client.subscribe(gameStateTopic);
}

void messageReceived(String topic, byte[] payload) {
  String incomingPayload = new String(payload);
  if(topic.equals(gameStateTopic)){
      gameState= parseJSONObject(incomingPayload);
  }
}

void connectionLost() {
  println("connection lost");
}
