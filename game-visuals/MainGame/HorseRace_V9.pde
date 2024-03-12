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

int moveGreen=0;
int move

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
}

//This function is what is shown during the drinking phase aka the 15 minutes
void idlePhaseHorses() {
  startingBackground();
}

void resetHorseValues(){
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
     
}

void drawHorses(int green, int purple, int orange, int blue, int red) {
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
