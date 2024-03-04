JSONObject gameState;


void setup() {
  fullScreen();

  gameState = parseJSONObject("{\"round\":5,\"state\":\"play\", \"ranking\": {\"red\":1, \"orange\":2, \"green\":3, \"blue\":4, \"purple\":5}}");
  setupHorses();
  //setupMQTT();
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
    switch(state) {
    case "drinking":
      idlePhaseHorses();
      break;
    case "play":
      drawHorses(ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    println(round, state);
    break;
    // code block
  }
}
