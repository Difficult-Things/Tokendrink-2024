int xWinner = 0;
int xSecond = 0;
int xThird = 0;
int xFourth = 0;
int xLast = 0;


int winningHorse(){
  if ((millis()<(10000+startingTime))&&(millis()>(6000+startingTime))){
    xWinner = xWinner + 1;
  }
  if ((millis()<(14000+startingTime))&&(millis()>(10000+startingTime))){
    xWinner = xWinner + 3;
  }
  if ((millis()<(21000+startingTime))&&(millis()>(14000+startingTime))){
  xWinner = xWinner +0;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(21000+startingTime))){
  xWinner = xWinner - 1;
  }
  if ((millis()<(30000+startingTime))&&(millis()>(28000+startingTime))){
    xWinner = xWinner + 0;
  }
  if ((millis()<(35000+startingTime))&&(millis()>(30000+startingTime))){
    xWinner = xWinner + 4;
  }
  if ((millis()<(40000+startingTime))&&(millis()>(35000+startingTime))){
    xWinner = xWinner - 3;
  }
  if ((millis()<(42000+startingTime))&&(millis()>(40000+startingTime))){
    xWinner = xWinner -1;
  }
  if ((millis()<(48000+startingTime))&&(millis()>(42000+startingTime))){
    xWinner = xWinner + 3;
  }
  if ((millis()<(53000+startingTime))&&(millis()>(48000+startingTime))){
    xWinner = xWinner + 1;
  }
  if ((millis()<(57000+startingTime))&&(millis()>(53000+startingTime))){
   xWinner = xWinner + 0;
  }
  if ((millis()<(63000+startingTime))&&(millis()>(57000+startingTime))){
    xWinner = xWinner+ 2;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(63000+startingTime))){
   xWinner = xWinner + 4;
  }
  return xWinner;
}

int secondHorse(){
  if ((millis()<(13000+startingTime))&&(millis()>(6000+startingTime))){
    xSecond = xSecond + 4;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(13000+startingTime))){
    xSecond = xSecond +3;
  } 
  if ((millis()<(27000+startingTime))&&(millis()>(15000+startingTime))){
    xSecond = xSecond -2;
  }
  if ((millis()<(290000+startingTime))&&(millis()>(23000+startingTime))){
    xSecond = xSecond +0;
  }
  if ((millis()<(35000+startingTime))&&(millis()>(29000+startingTime))){
    xSecond = xSecond +3;
  }
  if ((millis()<(45000+startingTime))&&(millis()>(35000+startingTime))){
    xSecond = xSecond -2;
  }
  if ((millis()<(53000+startingTime))&&(millis()>(45000+startingTime))){
    xSecond = xSecond +0;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(53000+startingTime))){
    xSecond = xSecond +2;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(60000+startingTime))){
    xSecond = xSecond +6;
  }
  return xSecond;
}

int thirdHorse(){
  if ((millis()<(8000+startingTime))&&(millis()>(6000+startingTime))){
    xThird = xThird + 3;
  }
  if ((millis()<(13000+startingTime))&&(millis()>(8000+startingTime))){
    xThird = xThird + 2;
  }
  if ((millis()<(20000+startingTime))&&(millis()>(13000+startingTime))){
    xThird = xThird + 1;
  }
  if ((millis()<(24000+startingTime))&&(millis()>(20000+startingTime))){
    xThird = xThird +0;
  }
  if ((millis()<(26000+startingTime))&&(millis()>(24000+startingTime))){
    xThird = xThird + 1;
  }
  if ((millis()<(30000+startingTime))&&(millis()>(26000+startingTime))){
    xThird = xThird -3;
  }
  if ((millis()<(34000+startingTime))&&(millis()>(30000+startingTime))){
    xThird = xThird + 1;
  }
  if ((millis()<(38000+startingTime))&&(millis()>(34000+startingTime))){
    xThird = xThird + 0;
  }
  if ((millis()<(43000+startingTime))&&(millis()>(38000+startingTime))){
    xThird = xThird + -1;
  }
  if ((millis()<(51000+startingTime))&&(millis()>(43000+startingTime))){
    xThird = xThird + 3;
  }
  if ((millis()<(55000+startingTime))&&(millis()>(51000+startingTime))){
    xThird = xThird -2;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(55000+startingTime))){
    xThird = xThird -1;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(60000+startingTime))){      // "dies at 60-6 sec
    xThird = xThird -5;
  }
  if((millis()<(86000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xThird = xThird +3;
  }
  return xThird; 
}

int fourthHorse(){
  if ((millis()<(9000+startingTime))&&(millis()>(6000+startingTime))){
    xFourth = xFourth + 5;
  }
  if ((millis()<(11000+startingTime))&&(millis()>(9000+startingTime))){
    xFourth = xFourth + 1;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(11000+startingTime))){
    xFourth = xFourth - 3;
  }
  if ((millis()<(24000+startingTime))&&(millis()>(18000+startingTime))){
    xFourth = xFourth -1;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(24000+startingTime))){
    xFourth = xFourth + 2;
  }
  if ((millis()<(31000+startingTime))&&(millis()>(28000+startingTime))){
    xFourth = xFourth + 4;
  }
  if ((millis()<(39000+startingTime))&&(millis()>(31000+startingTime))){
    xFourth = xFourth - 3;
  }
  if ((millis()<(42000+startingTime))&&(millis()>(39000+startingTime))){
    xFourth = xFourth + 5;
  }
  if ((millis()<(46000+startingTime))&&(millis()>(42000+startingTime))){
    xFourth = xFourth + 2;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(46000+startingTime))){      //dies
    xFourth = xFourth - 5;
  }  
  if((millis()<(102000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xFourth = xFourth +4;
  }
  return xFourth; 
}

int lastHorse(){
  if ((millis()<(7000+startingTime))&&(millis()>(6000+startingTime))){
    xLast = xLast -5;
  }
  if ((millis()<(9000+startingTime))&&(millis()>(7000+startingTime))){
    xLast = xLast +1;
  }
  if ((millis()<(13000+startingTime))&&(millis()>(9000+startingTime))){
    xLast = xLast +2;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(13000+startingTime))){
    xLast = xLast +1;
  }
  if ((millis()<(22000+startingTime))&&(millis()>(18000+startingTime))){
    xLast = xLast -4;
  }
  if ((millis()<(24000+startingTime))&&(millis()>(22000+startingTime))){
    xLast = xLast -2;
  }
  if ((millis()<(29000+startingTime))&&(millis()>(24000+startingTime))){
    xLast = xLast +3;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(29000+startingTime))){    //dies
    xLast = xLast -5;
  }
  if((millis()<(144000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xLast = xLast +3;
  }
  return xLast;
}
