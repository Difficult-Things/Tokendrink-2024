int a = -30;
int b = -15;
int lastHorseFrame;


void baseHorse(int xSpot, int ySpot,color accent1, color accent2){
  noStroke();
  
  if(frameCount-startingFrames == a+30){
    lastHorseFrame=1;
    a = frameCount-startingFrames;
  }
  if(lastHorseFrame==1){
    horse1accent1.disableStyle();
    horse1accent2.disableStyle();
    
    background(255);
    shape(horse1, xSpot,ySpot, 200,200);  
    
    fill(accent1);
    shape(horse1accent1,xSpot,ySpot,200,200);
    fill(accent2);
    shape(horse1accent2,xSpot,ySpot,200,200);
    
    
  }
  if(frameCount-startingFrames == b+30){
    lastHorseFrame=2;
    b = frameCount-startingFrames;
  } 
  if(lastHorseFrame==2){
    horse2accent1.disableStyle();
    horse2accent2.disableStyle();
    
    background(255);
    shape(horse2, xSpot,ySpot,200,200);
    
    fill(accent1);
    shape(horse2accent1,xSpot,ySpot,200,200);
    fill(accent2);
    shape(horse2accent2,xSpot,ySpot,200,200);
    
   
  }
}

void horseGreen(int xGreen){
  baseHorse(260 + xGreen, 375,#009040,#0CA54F);

}
void horsePurple(int xPurple){
  baseHorse(220+ xPurple, 525,#5a12b0, #4D1593);
 
}
void horseBlue(int xBlue){
  baseHorse(180+xBlue,675,#0857c3, #0B438E);

}
void horseRed(int xRed){
  baseHorse(140+xRed, 825,#ba0c2f, #900624);
  
}
void horseOrange(int xOrange){
  baseHorse(100+xOrange, 975, #ec681c, #D3510B);
  
}
