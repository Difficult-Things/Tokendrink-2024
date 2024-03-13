PImage background_mountains;
PImage background_fence;
PImage background_clouds;
int horseStart = 0;
int startingTime;
int startingFrames;

PShape horse1;
PShape horse1accent1;
PShape horse1accent2;

PShape horse2;
PShape horse2accent1;
PShape horse2accent2;



PFont WinningFont;
int countdownPaard = 20;
boolean messageWinnerSent = false;
void setupHorses() {
  noStroke();
  background(0);
  background_mountains = loadImage("mountains_TokenDrink.png");
  background_fence = loadImage("fence_TokenDrink.png");
  background_clouds = loadImage("clouds_TokenDrink.png");
  
  horse1= loadShape("horserunnerWithChildren.svg");
  horse1accent1 = horse1.getChild("Accent1");
  horse1accent2 = horse1.getChild("Accent2");
  
  horse2= loadShape("horserunnerWithChildren_pos2.svg");
  horse2accent1 = horse2.getChild("Accent1");
  horse2accent2 = horse2.getChild("Accent2");
  WinningFont = createFont("Arial Bold", 110);
}

//This function is what is shown during the idle phase aka the 15 minutes
void idlePhaseHorses() {
  startingBackground();
}

void resetHorseValues() {
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
  countdownPaard = 20;
}

void drawHorses(int green, int purple, int orange, int blue, int red) {

  if (countdownPaard >= 0) {
    startingBackground();
    pushStyle();
    textFont(Font1);
    textAlign(CENTER);
    fill(255, 0, 0);
    if (countdownPaard >= 0) {
      text(countdownPaard, width/2, height/2+180);
    }
    delay(1000);
    popStyle();
    countdownPaard--;
  }
  if (countdownPaard >= 0) {
    return;
  }

  if ((horseStart == 0)) {
    horseStart =1;
    startingTime = millis();
    startingFrames = frameCount;
  }
  if (horseStart == 0) {
    startingBackground();
  }
  if (horseStart == 1) {
   
    movingBackground();
    
    
    
    horseGreen(getPosition(green));
    horsePurple(getPosition(purple));
    horseBlue(getPosition(blue));
    horseRed(getPosition(red));
    horseOrange(getPosition(orange));
  }
  if (millis() > startingTime + 61000 && startingTime != 0) {
    pushStyle();
    String winningText = "";
    if (green == 1) {
      if (!messageWinnerSent) {
        messageWinnerSent = true;
        client.publish("finalWinner", "0", 2, false);
      }

      fill(#009040);
      winningText = "Team GREEN has won\r\n this year's tokendrink!";
    } else if (orange == 1) {
      if (!messageWinnerSent) {
        messageWinnerSent = true;
        client.publish("finalWinner", "2");
      }

      fill(#EC681C);
      winningText = "Team ORANGE has won\r\n this year's tokendrink!";
    } else if (purple == 1) {
      if (!messageWinnerSent) {
        messageWinnerSent = true;
        client.publish("finalWinner", "1");
      }
      fill(#7724DE);
      winningText = "Team PURPLE has won\r\n this year's tokendrink!";
    } else if (blue == 1) {
      if (!messageWinnerSent) {
        messageWinnerSent = true;
        client.publish("finalWinner", "3");
      }
      fill(#3280EA);
      winningText = "Team BLUE has won\r\n this year's tokendrink!";
    } else if (red == 1) {
      if (!messageWinnerSent) {
        messageWinnerSent = true;
        client.publish("finalWinner", "4");
      }
      fill(#BA0C2F);
      winningText = "Team RED has won\r\n this year's tokendrink!";
    }
    textFont(WinningFont);
    textAlign(CENTER);
    text(winningText, 900, 500);
    popStyle();
  }
}

int getPosition(int rank) {
  switch(rank) {
  case 1:
    return(winningHorse());
  case 2:
    return(secondHorse());
  case 3:
    return(thirdHorse());
  case 4:
    return(fourthHorse());
  case 5:
    return(lastHorse());

  default:
    return 0;
  }
}
