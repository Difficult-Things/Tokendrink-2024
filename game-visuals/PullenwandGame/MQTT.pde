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

  client.subscribe(gameStateTopic, 2);
    client.subscribe(winTopic, 2);

}

void messageReceived(String topic, byte[] payload) {
  String incomingPayload = new String(payload);
  if(topic.equals(gameStateTopic)){
      gameState= parseJSONObject(incomingPayload);
  }
    if(topic.equals(winTopic)){
      int winningColor = parseInt(new String(payload));
      if(winningColor == 0){
        fill(#009040);
      }
            if(winningColor == 1){
        fill(#5A12B0);
      }
            if(winningColor == 2){
        fill(#EC681C);
      }
            if(winningColor == 3){
        fill(#0857C3);
      }
            if(winningColor == 4){
        fill(#BA0C2F);
      }
      rect(0,0,width,height);
      delay(100);
      //gameState= parseJSONObject(incomingPayload);
  }

}

void connectionLost() {
  println("connection lost");
}
