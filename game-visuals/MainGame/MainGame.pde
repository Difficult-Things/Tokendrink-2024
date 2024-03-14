JSONObject gameState;
import processing.video.*;


Movie rouletteVideo;
Movie slotsVideo;
Movie plinkoVideo;
Movie grijperVideo;
Movie paardenVideo;



void setup() {
  //fullScreen(2);


  size(1920, 1080);
  gameState = parseJSONObject("{\"round\":1,\"state\":\"drinking\", \"ranking\": {\"green\":3, \"purple\":5, \"orange\":4, \"blue\":1, \"red\":2}}");
  setupHorses();
  setupGrijper();
  setupPlinko();
  setupSlots();
  setupRoulette();

  rouletteVideo = new Movie(this, "Roulette Screensaver.mp4");
  slotsVideo = new Movie(this, "Slot Machine Screensaver.mp4");
  plinkoVideo = new Movie(this, "Plinko Screensaver.mp4");
  grijperVideo = new Movie(this, "Claw_Machine_Screensaver.mp4");
  paardenVideo = new Movie(this, "Horse Racing Screensaver.mp4");

  //Comment line below if testing without MQTT
  setupMQTT();
  delay(100);
}

void draw() {
  int round = gameState.getInt("round");
  String state = gameState.getString("state");
  
  //int round = 5;
  //String state = "play";
  JSONObject ranking = gameState.getJSONObject("ranking");



  switch(round) {
  case 1:
    switch(state) {
    case "drinking":
      pushStyle();
      rouletteVideo.play();
      if (is_movie_finished(rouletteVideo)) {
        rouletteVideo.jump(0);
      }
      image(rouletteVideo, 0, 0);
      popStyle();
      resetRouletteValues();
      //drawRoulette(false, false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "reveal":
      drawRoulette(false, true, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "play":
      drawRoulette(true, false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 2:
    switch(state) {
    case "drinking":
      pushStyle();
      slotsVideo.play();
      if (is_movie_finished(slotsVideo)) {
        slotsVideo.jump(0);
      }
      image(slotsVideo, 0, 0);
      popStyle();
      resetSlotValues();
      //drawSlots(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
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
    switch(state) {
    case "drinking":
      pushStyle();
      plinkoVideo.play();
      if (is_movie_finished(plinkoVideo)) {
        plinkoVideo.jump(0);
      }
      image(plinkoVideo, 0, 0);
      popStyle();
      resetPlinkoValues();
      break;
    case "reveal":
      drawPlinko(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "play":
      drawPlinko(true, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 4:
    switch(state) {
    case "drinking":
      pushStyle();
      grijperVideo.play();
      if (is_movie_finished(grijperVideo)) {
        grijperVideo.jump(0);
      }
      image(grijperVideo, 0, 0);
      resetGrijperValues();
      popStyle();
      //drawGrijper(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "reveal":
      drawGrijper(false, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    case "play":
      grijperVideo.stop();
      drawGrijper(true, ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      break;
    }
    break;
  case 5:
    switch(state) {
    case "drinking":
      pushStyle();
      paardenVideo.play();
      if (is_movie_finished(paardenVideo)) {
        paardenVideo.jump(0);
      }
      image(paardenVideo, 0, 0);
      popStyle();
      resetHorseValues();
      //idlePhaseHorses();
      break;
    case "reveal":
      idlePhaseHorses();
      break;
    case "play":
      drawHorses(ranking.getInt("green"), ranking.getInt("purple"), ranking.getInt("orange"), ranking.getInt("blue"), ranking.getInt("red"));
      //drawHorses(1,2,3,4,5);
      break;
    }
    break;
    // code block
  }
}

void winningScreen(int winnerInput) {
  textAlign(LEFT, UP);
  imageMode(CORNER);
    image(backgroundSlots, 0, 0);

  //background(255, 255, 255);
  textSize(128);
  fill(0);
  switch(winnerInput) {
  case 0:
    fill(#009040);
    winner = "Green Wins!";
    break;
  case 1:
    fill(#7724DE);

    winner = "Purple Wins!";
    break;
  case 2:
    winner = "Orange Wins!";
    fill(#EC681C);

    break;
  case 3:
    fill(#3280EA);

    winner = "Blue Wins!";
    break;
  case 4:
    fill(#BA0C2F);

    winner = "Red Wins!";
    break;
  }
  text(winner, 40, 800);
  client.publish(winTopic, str(winnerInput));
  image(dave, 0, 0);
  delay(4000);
}

void movieEvent(Movie m) {
  m.read();
}

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}
