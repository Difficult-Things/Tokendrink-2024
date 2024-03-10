JSONObject gameState;





void setup() {
  //fullScreen();
  size(1920, 1080);
  gameState = parseJSONObject("{\"round\":4,\"state\":\"play\", \"ranking\": {\"green\":5, \"purple\":2, \"orange\":3, \"blue\":4, \"red\":1}}");
  setupHorses();
  setupGrijper();
  setupSlots();
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
    switch(state) {
    case "drinking":
      resetSlotValues();
      drawSlots(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "reveal":
      drawSlots(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "play":
      drawSlots(true, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 3:
  case 4:
    switch(state) {
    case "drinking":
      resetGrijperValues();
      drawGrijper(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "reveal":
      drawGrijper(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "play":
      drawGrijper(true, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 5:
    switch(state) {
    case "drinking":
      resetHorseValues();
      idlePhaseHorses();
      break;
    case "reveal":
      idlePhaseHorses();
      break;
    case "play":
      drawHorses(ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
    // code block
  }
}
