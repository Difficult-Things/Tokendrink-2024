int winnerValue=0;
int secondValue=0;
int thirdValue=0;
int fourthValue=0;
int lastValue=0;

int moveWinner(){
  if((millis()-startingTime>10)&&(millis()-startingTime<67000)){
   winnerValue=1; 
  }else{
    winnerValue=0; 
  }
  return winnerValue;
}

int moveSecond(){
  if((millis()-startingTime>10)&&(millis()-startingTime<71000)){
   secondValue=1; 
  }else{
    secondValue=0; 
  }
  return secondValue;
}

int moveThird(){
  if((millis()-startingTime>10)&&(millis()-startingTime<84000)){
   thirdValue=1; 
  }else{
    thirdValue=0; 
  }
  return thirdValue;
}

int moveFourth(){
  if((millis()-startingTime>10)&&(millis()-startingTime<91000)){
    fourthValue=1; 
  }else{
    fourthValue=0; 
  }
  return fourthValue;
}

int moveLast(){
  if((millis()-startingTime>10)&&(millis()-startingTime<93000)){
    lastValue=1; 
  }else{
    lastValue=0; 
  }
  return lastValue;
}
