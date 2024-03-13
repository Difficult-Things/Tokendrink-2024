import mqtt.*;
MQTTClient client;

void setupMQTT() {
  client = new MQTTClient(this);
  client.setWill(statusTopic, "OFFLINE", 2, true);
  client.connect(serverIP, uuid);
}


void clientConnected() {
  println("client connected");
  client.publish(statusTopic, "ONLINE", 2, true);

  client.subscribe(gameStateTopic, 2);
    client.subscribe(winTopic, 2);
    client.subscribe("finalWinner", 2);

}

void messageReceived(String topic, byte[] payload) {
  String incomingPayload = new String(payload);
  if(topic.equals(gameStateTopic)){
      gameState= parseJSONObject(incomingPayload);
  }
    if(topic.equals(winTopic)){
      int winningColor = parseInt(new String(payload));
      winningTeam = winningColor;
      winningTimer = millis();
     
      //gameState= parseJSONObject(incomingPayload);
  }
  
      if(topic.equals("finalWinner")){
      //int finalWinner = parseInt(new String(payload));
      finalWinner = parseInt(new String(payload));;
      //final = millis();
     
      //gameState= parseJSONObject(incomingPayload);
  }

}

void connectionLost() {
  println("connection lost");
}
