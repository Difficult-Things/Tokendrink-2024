JSONObject gameState;





void setup() {
  fullScreen();

  gameState = parseJSONObject("{\"round\":5,\"state\":\"play\", \"ranking\": {\"green\":1, \"purple\":2, \"orange\":3, \"blue\":4, \"red\":5}}");
  setupHorses();
  
  //Comment line below if testing without MQTT
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
  switch(state) {
    case "drinking":
      idlePhaseHorses();
      break;
    case "reveal":
      break;
    case "play":
      drawGrijper(ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 5:
    switch(state) {
    case "drinking":
      idlePhaseHorses();
      break;
    case "reveal":
      break;
    case "play":
      drawHorses(ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
    // code block
  }
}
