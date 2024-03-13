int xWinnerHorse = 0;
int xSecondHorse = 0;
int xThirdHorse = 0;
int xFourthHorse = 0;
int xLastHorse = 0;


int winningHorse(){
  if ((millis()<(1000+startingTime))&&(millis()>(startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(11000+startingTime))&&(millis()>(7000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(12000+startingTime))&&(millis()>(5000+startingTime))){
  xWinnerHorse = xWinnerHorse +0;
  }
  if ((millis()<(25000+startingTime))&&(millis()>(18000+startingTime))){
  xWinnerHorse = xWinnerHorse - 2;
  }
  if ((millis()<(27000+startingTime))&&(millis()>(25000+startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(32000+startingTime))&&(millis()>(27000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(37000+startingTime))&&(millis()>(32000+startingTime))){
    xWinnerHorse = xWinnerHorse - 2;
  }
  if ((millis()<(33000+startingTime))&&(millis()>(31000+startingTime))){
    xWinnerHorse = xWinnerHorse -1;
  }
  if ((millis()<(45000+startingTime))&&(millis()>(39000+startingTime))){
    xWinnerHorse = xWinnerHorse -1;
  }
  if ((millis()<(50000+startingTime))&&(millis()>(45000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(54000+startingTime))&&(millis()>(50000+startingTime))){
   xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(58000+startingTime))&&(millis()>(54000+startingTime))){
    xWinnerHorse = xWinnerHorse+ 2;
  }

  return xWinnerHorse;
}

int secondHorse(){
  if ((millis()<(10000+startingTime))&&(millis()>(3000+startingTime))){
    xSecondHorse = xSecondHorse + 2;
  }
  if ((millis()<(12000+startingTime))&&(millis()>(10000+startingTime))){
    xSecondHorse = xSecondHorse +1;
  } 
  if ((millis()<(24000+startingTime))&&(millis()>(12000+startingTime))){
    xSecondHorse = xSecondHorse -1;
  }
  if ((millis()<(260000+startingTime))&&(millis()>(24000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(32000+startingTime))&&(millis()>(26000+startingTime))){
    xSecondHorse = xSecondHorse +2;
  }
  if ((millis()<(36000+startingTime))&&(millis()>(32000+startingTime))){
    xSecondHorse = xSecondHorse -2;
  }
  if ((millis()<(44000+startingTime))&&(millis()>(36000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(62000+startingTime))&&(millis()>(50000+startingTime))){
    xSecondHorse = xSecondHorse +1;
  }

  return xSecondHorse;
}

int thirdHorse(){
  if ((millis()<(5000+startingTime))&&(millis()>(3000+startingTime))){
    xThirdHorse = xThirdHorse + 2;
  }
  if ((millis()<(10000+startingTime))&&(millis()>(5000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(11000+startingTime))&&(millis()>(1000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(11000+startingTime))){
    xThirdHorse = xThirdHorse +0;
  }
  if ((millis()<(17000+startingTime))&&(millis()>(15000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(21000+startingTime))&&(millis()>(17000+startingTime))){
    xThirdHorse = xThirdHorse +0;
  }
  if ((millis()<(23000+startingTime))&&(millis()>(21000+startingTime))){
    xThirdHorse = xThirdHorse -1;
  }
  if ((millis()<(27000+startingTime))&&(millis()>(23000+startingTime))){
    xThirdHorse = xThirdHorse -3;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(27000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(29000+startingTime))&&(millis()>(28000+startingTime))){
    xThirdHorse = xThirdHorse + 0;
  }
  if ((millis()<(34000+startingTime))&&(millis()>(290000+startingTime))){
    xThirdHorse = xThirdHorse + -1;
  }
  if ((millis()<(41000+startingTime))&&(millis()>(40000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(46000+startingTime))&&(millis()>(42000+startingTime))){
    xThirdHorse = xThirdHorse -2;
  }
  if ((millis()<(51000+startingTime))&&(millis()>(46000+startingTime))){
    xThirdHorse = xThirdHorse -1;
  }
  if ((millis()<(63000+startingTime))&&(millis()>(57000+startingTime))){      // "dies at 60-6 sec
    xThirdHorse = xThirdHorse -3;
  }
  if((millis()<(75000+startingTime))&&(millis()>(63000+startingTime))){      // finishline passing
    xThirdHorse = xThirdHorse +3;
  }
  return xThirdHorse; 
}

int fourthHorse(){
  if ((millis()<(3000+startingTime))&&(millis()>(3000+startingTime))){
    xFourthHorse = xFourthHorse + 3;
  }
  if ((millis()<(5000+startingTime))&&(millis()>(3000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(8000+startingTime))){
    xFourthHorse = xFourthHorse - 2;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(9000+startingTime))){
    xFourthHorse = xFourthHorse -1;
  }
  if ((millis()<(25000+startingTime))&&(millis()>(21000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(25000+startingTime))){
    xFourthHorse = xFourthHorse + 2;
  }
  if ((millis()<(36000+startingTime))&&(millis()>(28000+startingTime))){
    xFourthHorse = xFourthHorse - 2;
  }
  if ((millis()<(39000+startingTime))&&(millis()>(36000+startingTime))){
    xFourthHorse = xFourthHorse + 3;
  }
  if ((millis()<(43000+startingTime))&&(millis()>(39000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(63000+startingTime))&&(millis()>(43000+startingTime))){      //dies
    xFourthHorse = xFourthHorse - 3;
  }  
  if((millis()<(82000+startingTime))&&(millis()>(63000+startingTime))){      // finishline passing
    xFourthHorse = xFourthHorse +4;
  }
  return xFourthHorse; 
}

int lastHorse(){
  if ((millis()<(4000+startingTime))&&(millis()>(3000+startingTime))){
    xLastHorse = xLastHorse -2;
  }
  if ((millis()<(3000+startingTime))&&(millis()>(startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(4000+startingTime))&&(millis()>(startingTime))){
    xLastHorse = xLastHorse +2;
  }
  if ((millis()<(9000+startingTime))&&(millis()>(4000+startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(19000+startingTime))&&(millis()>(15000+startingTime))){
    xLastHorse = xLastHorse -3;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(13000+startingTime))){
    xLastHorse = xLastHorse -2;
  }
  if ((millis()<(26000+startingTime))&&(millis()>(21000+startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(63000+startingTime))&&(millis()>(26000+startingTime))){    //dies
    xLastHorse = xLastHorse -2;
  }
  if((millis()<(90000+startingTime))&&(millis()>(63000+startingTime))){      // finishline passing
    xLastHorse = xLastHorse +3;
  }
  return xLastHorse;
}
