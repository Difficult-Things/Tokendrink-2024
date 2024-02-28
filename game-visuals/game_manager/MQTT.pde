import mqtt.*;
MQTTClient client;

void setupMQTT() {
  client = new MQTTClient(this);
  client.setWill(statusTopic, "OFFLINE", 2, true);
  client.connect(serverIP, uuid);
}


void keyPressed() {
  client.publish("/hello", "world");
}

void clientConnected() {
  println("client connected");
  client.publish(statusTopic, "ONLINE");

  client.subscribe(gameStateTopic);
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}

void connectionLost() {
  println("connection lost");
}
