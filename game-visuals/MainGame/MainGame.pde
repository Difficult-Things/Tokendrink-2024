JSONObject gameState;
import processing.video.*;


Movie rouletteVideo;
Movie slotsVideo;
Movie plinkoVideo;
Movie grijperVideo;
Movie paardenVideo;



void setup() {
  fullScreen(2);


  //size(1920, 1080);
  gameState = parseJSONObject("{\"round\":1,\"state\":\"drinking\", \"ranking\": {\"green\":5, \"purple\":2, \"orange\":3, \"blue\":4, \"red\":1}}");
  setupHorses();
  setupGrijper();
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
      break;
    }
    break;
    // code block
  }
}

void movieEvent(Movie m) {
  m.read();
}

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}
