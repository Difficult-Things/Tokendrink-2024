int a = -10;
int b = -5;
int lastHorseFrame;

void baseHorse(int xSpot, int ySpot,color accent1, color accent2, int move){
  noStroke();
  if (millis()>6000+startingTime&& millis()<6100+startingTime){
    startingFrames=frameCount;
  }
  if((frameCount-startingFrames == a+10)&&(xSpot<500)){
    lastHorseFrame=1;
    a = frameCount-startingFrames;
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
  if((frameCount-startingFrames == b+10) /*&&( millis()>6000+startingTime)*/&&move ==1){
    lastHorseFrame=2;
    b = frameCount-startingFrames;
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
  }
  if (getPosition(green)==secondHorse()){
    moveGreen=moveSecond(); 
  }
  if(getPosition(green)==thirdHorse()){
    moveGreen=moveThird();
  }
  if(getPosition(green)==fourthHorse()){
   moveGreen=moveFourth(); 
  }
  if(getPosition(green)==lastHorse()){
   moveGreen=moveLast(); 
  }
  
  baseHorse(260+xGreen, 375,#009040,#0CA54F,moveGreen);

}
void horsePurple(int xPurple){
   if(getPosition(purple)==winningHorse()){
    movePurple=moveWinner();
  }
  if (getPosition(purple)==secondHorse()){
    movePurple=moveSecond(); 
  }
  if(getPosition(purple)==thirdHorse()){
    movePurple=moveThird();
  }
  if(getPosition(purple)==fourthHorse()){
   movePurple=moveFourth(); 
  }
  if(getPosition(purple)==lastHorse()){
   movePurple=moveLast(); 
  }
  
  baseHorse(220+ xPurple, 525,#5a12b0, #4D1593,movePurple);
 
}
void horseBlue(int xBlue){
  if(getPosition(blue)==winningHorse()){
    moveBlue=moveWinner();
  }
  if (getPosition(blue)==secondHorse()){
    moveBlue=moveSecond(); 
  }
  if(getPosition(blue)==thirdHorse()){
    moveBlue=moveThird();
  }
  if(getPosition(blue)==fourthHorse()){
   moveBlue=moveFourth(); 
  }
  if(getPosition(blue)==lastHorse()){
   moveBlue=moveLast(); 
  }
  
  
  baseHorse(180+xBlue,675,#0857c3, #0B438E,moveBlue);

}
void horseRed(int xRed){
   if(getPosition(red)==winningHorse()){
    moveRed=moveWinner();
  }
  if (getPosition(red)==secondHorse()){
    moveRed=moveSecond(); 
  }
  if(getPosition(red)==thirdHorse()){
    moveRed=moveThird();
  }
  if(getPosition(red)==fourthHorse()){
   moveRed=moveFourth(); 
  }
  if(getPosition(red)==lastHorse()){
   moveRed=moveLast(); 
  }
  
  baseHorse(140+xRed, 825,#ba0c2f, #900624,moveRed);
  
}
void horseOrange(int xOrange){
   if(getPosition(orange)==winningHorse()){
    moveOrange=moveWinner();
  }
  if (getPosition(orange)==secondHorse()){
    moveOrange=moveSecond(); 
  }
  if(getPosition(orange)==thirdHorse()){
    moveOrange=moveThird();
  }
  if(getPosition(orange)==fourthHorse()){
   moveOrange=moveFourth(); 
  }
  if(getPosition(orange)==lastHorse()){
   moveOrange=moveLast(); 
  }
  
  baseHorse(100+xOrange, 975, #ec681c, #D3510B,moveOrange);
  
}
