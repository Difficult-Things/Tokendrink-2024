JSONObject gameState;
import nl.mengin.lightcanvas.*;
LightCanvas lights;

void setup() {
  size(1600, 400);
  noSmooth(); //this makes the lightwall look better
  gameState = parseJSONObject("{\"round\":3,\"state\":\"play\", \"ranking\": {\"red\":1, \"orange\":2, \"green\":3, \"blue\":4, \"purple\":5}}");
  lights = new LightCanvas(this, "layout.json");
  setupPlinko();
  
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
    switch(state){
     case "drinking":
     //hier de visual die kwartiertje duurt ofzo
     break;
     case "reveal":
     break;
     case "play":
     if(!firstBall){dropBall();firstBall = true;}
     drawPlinko();
     break;
     
    }
    break;
  case 4:
    break;
  case 5:
    break;
    // code block
  }
}
