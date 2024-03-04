PImage background_mountains;
PImage background_fence;
PImage background_clouds;
int start = 0;
int startingTime;

void setupHorses() {
  noStroke();
  background(0);
  background_mountains = loadImage("mountains_TokenDrink.png");
  background_fence = loadImage("fence_TokenDrink.png");
  background_clouds = loadImage("clouds_TokenDrink.png");
}

//This function is what is shown during the drinking phase aka the 15 minutes
void idlePhaseHorses() {
  startingBackground();
}

void drawHorses(int green, int purple, int orange, int blue, int red) {
  if ((start == 0)) {
    start =1;
    startingTime = millis();
  }
  if (start == 0) {
    startingBackground();
  }
  if (start == 1) {
    movingBackground();

    horseGreen(getPosition(green));
    horsePurple(getPosition(purple));
    horseOrange(getPosition(orange));
    horseBlue(getPosition(blue));
    horseRed(getPosition(red));
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
