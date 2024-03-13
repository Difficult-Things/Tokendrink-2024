int a = -10;
int b = -5;
int lastHorseFrame=1;
boolean lastHorseFrameV2=true;

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
  if (millis()>startingTime&& millis()<100+startingTime){
    startingFrames=frameCount;
  }
  
  if(frameCount % 3 == 0){
     lastHorseFrameV2 = !lastHorseFrameV2; 
  }
   //println(accent1);
  if(frameCount-startingFrames >= a+10){
    a = frameCount-startingFrames;
    lastHorseFrame=1; 
  }
  if(lastHorseFrameV2){
    horse1accent1.disableStyle();
    horse1accent2.disableStyle();
    
    shape(horse1, xSpot-50,ySpot-350, 500,400);  
    
    fill(accent1);
    shape(horse1accent1,xSpot-50,ySpot-350,500,400);

    fill(accent2);
    shape(horse1accent2,xSpot-50,ySpot-350,500,400);

    
  }
  
  if((frameCount-startingFrames >= b+10)&&millis()>startingTime){
    b = frameCount-startingFrames;
    lastHorseFrame=2;
  } 
  
  if(!lastHorseFrameV2){
    horse2accent1.disableStyle();
    horse2accent2.disableStyle();
    
    shape(horse2, xSpot-45,ySpot-350,500,400);
    
    fill(accent1);
    shape(horse2accent1,xSpot-45,ySpot-350,500,400);

    fill(accent2);
    shape(horse2accent2,xSpot-45,ySpot-350,500,400);

   
  }
}

void horseGreen(int xGreen, int rank){
  if(rank == 1){
    moveGreen=moveWinner();
  }else if (rank == 2){
    moveGreen=moveSecond(); 
  }else if(rank == 3){
    moveGreen=moveThird();
  }else if(rank == 4){
   moveGreen=moveFourth(); 
  }else if(rank == 5){
   moveGreen=moveLast(); 
  }
  
  
  if(moveGreen==0){
    baseHorseStill(260+xGreen, 375,#009040,#0CA54F);
  }
  if(moveGreen==1){
    baseHorseMoving(260+xGreen, 375,#009040,#0CA54F);
  }
}
void horsePurple(int xPurple, int rank){
  if(rank == 1){
    movePurple=moveWinner();
  }else if (rank == 2){
    movePurple=moveSecond(); 
  }else if(rank == 3){
    movePurple=moveThird();
  }else if(rank == 4){
   movePurple=moveFourth(); 
  }else if(rank == 5){
   movePurple=moveLast(); 
  }
  if(movePurple==0){
    baseHorseStill(220+ xPurple, 525,#5a12b0, #4D1593);
  }
  if(movePurple==1){
    baseHorseMoving(220+ xPurple, 525,#5a12b0, #4D1593);
  }
}
void horseBlue(int xBlue, int rank){
  if(rank == 1){
    moveBlue=moveWinner();
  }else if (rank == 2){
    moveBlue=moveSecond(); 
  }else if(rank == 3){
    moveBlue=moveThird();
  }else if(rank == 4){
   moveBlue=moveFourth(); 
  }else if(rank == 5){
   moveBlue=moveLast(); 
  }
  
  if(moveBlue==0){
  baseHorseStill(180+xBlue,675,#0857c3, #0B438E);
  }
  
 if(moveBlue==1){
   baseHorseMoving(180+xBlue,675,#0857c3, #0B438E);
 }
}
void horseRed(int xRed, int rank){
   if(rank == 1){
    moveRed=moveWinner();
  }else if (rank == 2){
    moveRed=moveSecond(); 
  }else if(rank == 3){
    moveRed=moveThird();
  }else if(rank == 4){
   moveRed=moveFourth(); 
  }else if(rank == 5){
   moveRed=moveLast(); 
  }
  if (moveRed==0){
    baseHorseStill(140+xRed, 825,#ba0c2f, #900624);
  }
  if(moveRed==1){
     baseHorseMoving(140+xRed, 825,#ba0c2f, #900624);
  }
  
}
void horseOrange(int xOrange, int rank){
   if(rank == 1){
    moveOrange=moveWinner();
  } else if (rank == 2){
    moveOrange=moveSecond(); 
  }else if(rank == 3){
    moveOrange=moveThird();
  }else if(rank == 4){
   moveOrange=moveFourth(); 
  }else if(rank == 5){
   moveOrange=moveLast(); 
  }
  if (moveOrange==0){
    baseHorseStill(100+xOrange, 975, #ec681c, #D3510B);
  }
  if (moveOrange==1){
    baseHorseMoving(100+xOrange, 975, #ec681c, #D3510B);
  }
}
