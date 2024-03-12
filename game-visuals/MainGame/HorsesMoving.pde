int winnerValue=0;
int secondValue=0;
int thirdValue=0;
int fourthValue=0;
int lastValue=0;

int moveWinner(){
  if((millis()+startingTime>6000)&&(millis()+startingTime<66000)){
   winnerValue=1; 
  }
  if (millis()+startingTime>66000){
    winnerValue=0; 
  }
  return winnerValue;
}

int moveSecond(){
  if((millis()+startingTime>6000)&&(millis()+startingTime<66000)){
   secondValue=1; 
  }
  if (millis()+startingTime>66000){
    secondValue=0; 
  }
  return secondValue;
}

int moveThird(){
  if((millis()+startingTime>6000)&&(millis()+startingTime<86000)){
   thirdValue=1; 
  }
  if (millis()+startingTime>86000){
    thirdValue=0; 
  }
  return thirdValue;
}

int moveFourth(){
  if((millis()+startingTime>6000)&&(millis()+startingTime<102000)){
    fourthValue=1; 
  }
  if (millis()+startingTime>102000){
    fourthValue=0; 
  }
  return fourthValue;
}

int moveLast(){
  if((millis()+startingTime>6000)&&(millis()+startingTime<144000)){
    lastValue=1; 
  }
  if (millis()+startingTime>144000){
    lastValue=0; 
  }
  return lastValue;
}
