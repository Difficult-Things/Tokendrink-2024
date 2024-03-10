//int winningBall = 4; // 0: Oranje, 1: Rood, 2: Blauw, 3: Groen, 4: Paars

PImage backgroundImg, forgroundImg, grabber, ball, dave;
int grabberMatrixX = -304/2;
int grabberMatrixY = -1400;
int grabberX = 0;
int grabberY = 0;
int lastBallPosX;
float lastBallPosY;
int grabberYMax = 1200;
int numberOfTries = 2;
int currentTry = 0;
float gravity = 10;
int[] fallLimit = new int[numberOfTries];
int[] randomMoveX = new int[numberOfTries];
boolean wentDown = false;
boolean xReached = false;
String[] images = {"Bal Groen.png", "Bal Paars.png", "Bal Oranje.png", "Bal Blauw.png", "Bal Rood.png"};
String winner = "... Wins!";


void resetGrijperValues(){
        grabberMatrixX = -304/2;
      grabberMatrixY = -1400;
      grabberX = 0;
      grabberY = 0;
      grabberYMax = 1200;
      currentTry = 0;
      gravity = 10;
      wentDown = false;
      xReached = false;
}

void setupGrijper() {
  backgroundImg = loadImage("Grijper_Background.png");
  forgroundImg = loadImage("GrijperForground.png");
  grabber = loadImage("Grabber.png");
  dave = loadImage("Dave.png");
  for (int i = 0; i < numberOfTries; i++){
    randomMoveX[i] = int(random(500, width-500));
    fallLimit[i] = int(random(200, height-600));
  }
}

void drawGrijper(boolean start, int green, int purple, int orange, int blue, int red) {
  int winnerInput = 0;
  if(green == 1){
    winnerInput = 0;
  }
    else if(purple == 1){
    winnerInput = 1;
  }
    else if(orange == 1){
    winnerInput = 2;
  }
    else if(blue == 1){
    winnerInput = 3;
  }
    else if(red == 1){
    winnerInput = 4;
  }
  
  if(start){
      if (currentTry < numberOfTries) {
    backgroundImg();
    grabber(winnerInput);
    forgroundImg();
  } else {
    winningScreen(winnerInput);
  }
  }
  else{
   backgroundImg();
   forgroundImg();
  }

}

void backgroundImg() {
  image(backgroundImg, 0, 0);
}

void forgroundImg() {
  image(forgroundImg, 0, height - 310);
}

void grabber(int winnerInput) {
  pushMatrix();
  translate(grabberMatrixX + grabberX, grabberMatrixY + grabberY);
  grabberMoveX(winnerInput);
  grabberMoveY();
  ball();
  image(grabber, 0, 0);
  popMatrix();
}

void grabberMoveX(int winnerInput) {
  if (grabberX < randomMoveX[currentTry] && xReached == false) {
    grabberX += 5;
    if (grabberX >= randomMoveX[currentTry]) {
      ballColor(winnerInput);
    }
  } else if (grabberX > randomMoveX[currentTry] && xReached == false) {
    grabberX -= 5;
    if (grabberX <= randomMoveX[currentTry]) {
      ballColor(winnerInput);
    }
  }
}

void ballColor(int winnerInput) {
  xReached = true;
  if (currentTry < numberOfTries-1){
    ball = loadImage(images[int(random(0,5))]);
  } else if (currentTry == numberOfTries-1) {
    ball = loadImage(images[winnerInput]);
  }
}

void grabberMoveY() {
  if (xReached == true) {
    if (grabberY < grabberYMax && wentDown == false) {
      gravity = 10;
      grabberY += 5;
    } else if (grabberY > 0) {
      wentDown = true;
      grabberY -= 5;
    } else if (wentDown == true && grabberY <= 0){
      if (currentTry == numberOfTries - 1) {
        delay(1500);
      }
      wentDown = false;
      xReached = false;
      currentTry++;
    }
  }
}

void ball() {
  if (wentDown == true) {
    if (grabberY < fallLimit[currentTry] && currentTry < numberOfTries-1) {
      lastBallPosY = lastBallPosY + gravity;
      gravity *= 1.05;
      image(ball, lastBallPosX, lastBallPosY);
    } else {
      lastBallPosX = -grabberMatrixX - 175/2;
      lastBallPosY = -grabberMatrixY + 220;
      image(ball, lastBallPosX, lastBallPosY);
    }
  }
}

void winningScreen(int winnerInput) {
  background(255, 255, 255);
  textSize(128);
  fill(0);
  switch(winnerInput) {
    case 0: 
      winner = "Green Wins!";
      break;
    case 1: 
      winner = "Purple Wins!";
      break;
    case 2: 
      winner = "Orange Wins!";
      break;
    case 3: 
      winner = "Blue Wins!";
      break;
    case 4: 
      winner = "Red Wins!";
      break;
  }
  text(winner, 40, 800);
  image(dave, 0, 0);
}
