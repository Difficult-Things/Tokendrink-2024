JSONObject gameState;


void setup() {
  gameState = parseJSONObject("{\"round\":5,\"state\":\"play\", \"ranking\": {\"red\":1, \"orange\":2, \"green\":3, \"blue\":4, \"purple\":5}}");
  
  //Comment line below if testing without MQTT running
  setupMQTT(); 
  delay(100);
}

void draw() {
  int round = gameState.getInt("round");
  String state = gameState.getString("state");
  JSONObject ranking = gameState.getJSONObject("ranking");


  switch(round) {
  case 1:
    break;
  case 2:
    break;
  case 3:
  case 4:
    break;
  case 5:  
    break;
    // code block
  }
}
