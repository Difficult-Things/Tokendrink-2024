PImage background_mountains;
PImage background_fence;
PImage background_clouds;
int start = 0;
int startingTime;

void setup(){
  fullScreen();
  noStroke();
  background(0);
  background_mountains = loadImage("mountains_TokenDrink.png");
  background_fence = loadImage("fence_TokenDrink.png");
  background_clouds = loadImage("clouds_TokenDrink.png");
}

void draw(){
  if ((mousePressed==true)&&(start == 0)){
    start =1;
    startingTime = millis();
    
  }
  if (start == 0){
    startingBackground();
  }
  if (start == 1){
    movingBackground();
    
    horseGreen(winningHorse());
    horsePurple(secondHorse());
    horseOrange(thirdHorse());
    horseBlue(fourthHorse());
    horseRed(lastHorse());
  }
  
}
