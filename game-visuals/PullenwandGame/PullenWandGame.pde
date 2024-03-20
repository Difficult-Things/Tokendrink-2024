JSONObject gameState;
import nl.mengin.lightcanvas.*;
LightCanvas lights;
int winningTeam = -1;
int winningTimer = 0;
int finalWinner = -1;

import processing.video.*;
Movie idleVideo;

void setup() {
  size(1600, 400);
  noSmooth(); //this makes the lightwall look better
  gameState = parseJSONObject("{\"round\":1,\"state\":\"drinking\", \"ranking\": {\"red\":1, \"orange\":2, \"green\":3, \"blue\":4, \"purple\":5}}");
  lights = new LightCanvas(this, "layout.json");
  setupPlinko();
    idleVideo = new Movie(this, "Pullenwand_screensaver.mp4");


  //Comment line below if testing without MQTT running
  setupMQTT();
  delay(100);
}

void draw() {
  int round = gameState.getInt("round");
  String state = gameState.getString("state");
  JSONObject ranking = gameState.getJSONObject("ranking");
  if (finalWinner >= 0) {
    if (finalWinner == 0) {
      fill(0, 255, 0);
    }
    if (finalWinner == 1) {
      fill(255, 0, 255);
    }
    if (finalWinner == 2) {
      fill(255, 100, 0);
    }
    if (finalWinner == 3) {
      fill(0, 0, 255);
    }
    if (finalWinner == 4) {
      fill(255, 0, 0);
    }
    rect(0, 0, width, height);
    return;
  }

  if (millis() - winningTimer < 2000) {
    if (winningTeam == 0) {
      fill(0, 255, 0);
    }
    if (winningTeam == 1) {
      fill(255, 0, 255);
    }
    if (winningTeam == 2) {
      fill(255, 100, 0);
    }
    if (winningTeam == 3) {
      fill(0, 0, 255);
    }
    if (winningTeam == 4) {
      fill(255, 0, 0);
    }
    rect(0, 0, width, height);
  } else {

    background(0);
    switch(round) {
    case 1:
          pushStyle();
      idleVideo.play();
      if (is_movie_finished(idleVideo)) {
        idleVideo.jump(0);
      }
      image(idleVideo, 0, 0);
      popStyle();
      break;
    case 2:
      pushStyle();
      idleVideo.play();
      if (is_movie_finished(idleVideo)) {
        idleVideo.jump(0);
      }
      image(idleVideo, 0, 0);
      popStyle();
      break;
    case 3:
      switch(state) {
      case "drinking":
        if (!firstBall) {
          dropBall();
          firstBall = true;
        }
        drawPlinko();
        break;
      case "reveal":
        if (!firstBall) {
          dropBall();
          firstBall = true;
        }
        drawPlinko();
        break;
      case "play":
        if (!firstBall) {
          dropBall();
          firstBall = true;
        }
        drawPlinko();
        break;
      }
      break;
    case 4:
      pushStyle();
      idleVideo.play();
      if (is_movie_finished(idleVideo)) {
        idleVideo.jump(0);
      }
      image(idleVideo, 0, 0);
      popStyle();
      break;
    case 5:
      pushStyle();
      idleVideo.play();
      if (is_movie_finished(idleVideo)) {
        idleVideo.jump(0);
      }
      image(idleVideo, 0, 0);
      popStyle();
      break;
      // code block
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}
