JSONObject gameState;

void setup() {
  gameState = parseJSONObject("{\"round\":1,\"state\":\"drinking\"}");
  setupMQTT();
  delay(100);
}

void draw() {
  int round = gameState.getInt("round");
  String state = gameState.getString("state");

  switch(round) {
  case 1:
    println(round, state);
    // code block
    break;
  case 2:
    println(round, state);
    // code block
    break;
  case 3:
    println(round, state);
  case 4:
    println(round, state);
    break;
  case 5:
    println(round, state);
    break;
    // code block
  }


}
