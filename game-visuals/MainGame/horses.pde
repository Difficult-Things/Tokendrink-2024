int a = -10;
int b = -5;
int lastHorseFrame=1;

int moveGreen = 0;
int movePurple=0;
int moveBlue=0;
int moveRed=0;
int moveOrange=0;

int green;
int purple;
int red;
int blue;
int orange;
void baseHorseStill(int xSpot, int ySpot,color accent1, color accent2){
    horse1accent1.disableStyle();
    horse1accent2.disableStyle();
    
    shape(horse1, xSpot-50,ySpot-350, 500,400);  
    
    fill(accent1);
    shape(horse1accent1,xSpot-50,ySpot-350,500,400);
    fill(accent2);
    shape(horse1accent2,xSpot-50,ySpot-350,500,400);
}

void baseHorseMoving(int xSpot, int ySpot,color accent1, color accent2){
  noStroke();
  if (millis()>6000+startingTime&& millis()<6100+startingTime){
    startingFrames=frameCount;
  }
   
  if(frameCount-startingFrames == a+10){
    a = frameCount-startingFrames;
    lastHorseFrame=1; 
  }
  if(lastHorseFrame==1){
    horse1accent1.disableStyle();
    horse1accent2.disableStyle();
    
    shape(horse1, xSpot-50,ySpot-350, 500,400);  
    
    fill(accent1);
    shape(horse1accent1,xSpot-50,ySpot-350,500,400);
    fill(accent2);
    shape(horse1accent2,xSpot-50,ySpot-350,500,400);
    
    
  }
  
  if((frameCount-startingFrames == b+10)&&millis()>6000+startingTime){
    b = frameCount-startingFrames;
    lastHorseFrame=2;
  } 
  
  if(lastHorseFrame==2){
    horse2accent1.disableStyle();
    horse2accent2.disableStyle();
    
    shape(horse2, xSpot-45,ySpot-350,500,400);
    
    fill(accent1);
    shape(horse2accent1,xSpot-45,ySpot-350,500,400);
    fill(accent2);
    shape(horse2accent2,xSpot-45,ySpot-350,500,400);
   
  }
}

void horseGreen(int xGreen){
  if(getPosition(green)==winningHorse()){
    moveGreen=moveWinner();
  }else if (getPosition(green)==secondHorse()){
    moveGreen=moveSecond(); 
  }else if(getPosition(green)==thirdHorse()){
    moveGreen=moveThird();
  }else if(getPosition(green)==fourthHorse()){
   moveGreen=moveFourth(); 
  }else if(getPosition(green)==lastHorse()){
   moveGreen=moveLast(); 
  }
  
  if(moveGreen==0){
    baseHorseStill(260+xGreen, 375,#009040,#0CA54F);
  }
  if(moveGreen==1){
    baseHorseMoving(260+xGreen, 375,#009040,#0CA54F);
  }
}
void horsePurple(int xPurple){
  if(getPosition(purple)==winningHorse()){
    movePurple=moveWinner();
  }else if (getPosition(purple)==secondHorse()){
    movePurple=moveSecond(); 
  }else if(getPosition(purple)==thirdHorse()){
    movePurple=moveThird();
  }else if(getPosition(purple)==fourthHorse()){
   movePurple=moveFourth(); 
  }else if(getPosition(purple)==lastHorse()){
   movePurple=moveLast(); 
  }
  if(movePurple==0){
    baseHorseStill(220+ xPurple, 525,#5a12b0, #4D1593);
  }
  if(movePurple==1){
    baseHorseMoving(220+ xPurple, 525,#5a12b0, #4D1593);
  }
}
void horseBlue(int xBlue){
  if(getPosition(blue)==winningHorse()){
    moveBlue=moveWinner();
  }else if (getPosition(blue)==secondHorse()){
    moveBlue=moveSecond(); 
  }else if(getPosition(blue)==thirdHorse()){
    moveBlue=moveThird();
  }else if(getPosition(blue)==fourthHorse()){
   moveBlue=moveFourth(); 
  }else if(getPosition(blue)==lastHorse()){
   moveBlue=moveLast(); 
  }
  
  if(moveBlue==0){
  baseHorseStill(180+xBlue,675,#0857c3, #0B438E);
  }
  
 if(moveBlue==1){
   baseHorseMoving(180+xBlue,675,#0857c3, #0B438E);
 }
}
void horseRed(int xRed){
   if(getPosition(red)==winningHorse()){
    moveRed=moveWinner();
  }else if (getPosition(red)==secondHorse()){
    moveRed=moveSecond(); 
  }else if(getPosition(red)==thirdHorse()){
    moveRed=moveThird();
  }else if(getPosition(red)==fourthHorse()){
   moveRed=moveFourth(); 
  }else if(getPosition(red)==lastHorse()){
   moveRed=moveLast(); 
  }
  if (moveRed==0){
    baseHorseStill(140+xRed, 825,#ba0c2f, #900624);
  }
  if(moveRed==1){
     baseHorseMoving(140+xRed, 825,#ba0c2f, #900624);
  }
  
}
void horseOrange(int xOrange){
   if(getPosition(orange)==winningHorse()){
    moveOrange=moveWinner();
  } else if (getPosition(orange)==secondHorse()){
    moveOrange=moveSecond(); 
  }else if(getPosition(orange)==thirdHorse()){
    moveOrange=moveThird();
  }else if(getPosition(orange)==fourthHorse()){
   moveOrange=moveFourth(); 
  }else if(getPosition(orange)==lastHorse()){
   moveOrange=moveLast(); 
  }
  if (moveOrange==0){
    baseHorseStill(100+xOrange, 975, #ec681c, #D3510B);
  }
  if (moveOrange==1){
    baseHorseMoving(100+xOrange, 975, #ec681c, #D3510B);
  }
}
