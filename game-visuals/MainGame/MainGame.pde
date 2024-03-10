JSONObject gameState;





void setup() {
  //fullScreen();
  size(1920, 1080);
  gameState = parseJSONObject("{\"round\":4,\"state\":\"play\", \"ranking\": {\"green\":5, \"purple\":2, \"orange\":3, \"blue\":4, \"red\":1}}");
  setupHorses();
  setupGrijper();
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
      grabberMatrixX = -304/2;
      grabberMatrixY = -1400;
      grabberX = 0;
      grabberY = 0;
      grabberYMax = 1200;
      currentTry = 0;
      gravity = 10;
      wentDown = false;
      xReached = false;
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
      horseStart = 0;
      xWinnerHorse = 0;
      xSecondHorse = 0;
      xThirdHorse = 0;
      xFourthHorse = 0;
      xLastHorse = 0;
      xMountains = 0;
      xFence = 0;
      xClouds = 0;
      xStart = 0;
      xFinish = 1700;
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
