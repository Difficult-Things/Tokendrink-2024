int xWinnerHorse = 0;
int xSecondHorse = 0;
int xThirdHorse = 0;
int xFourthHorse = 0;
int xLastHorse = 0;


int winningHorse(){
  if ((millis()<(4000+startingTime))&&(millis()>(startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(14000+startingTime))&&(millis()>(10000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(8000+startingTime))){
  xWinnerHorse = xWinnerHorse +0;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(21000+startingTime))){
  xWinnerHorse = xWinnerHorse - 2;
  }
  if ((millis()<(30000+startingTime))&&(millis()>(28000+startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(35000+startingTime))&&(millis()>(30000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(40000+startingTime))&&(millis()>(35000+startingTime))){
    xWinnerHorse = xWinnerHorse - 2;
  }
  if ((millis()<(36000+startingTime))&&(millis()>(34000+startingTime))){
    xWinnerHorse = xWinnerHorse -1;
  }
  if ((millis()<(48000+startingTime))&&(millis()>(42000+startingTime))){
    xWinnerHorse = xWinnerHorse -1;
  }
  if ((millis()<(53000+startingTime))&&(millis()>(48000+startingTime))){
    xWinnerHorse = xWinnerHorse + 2;
  }
  if ((millis()<(57000+startingTime))&&(millis()>(53000+startingTime))){
   xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(61000+startingTime))&&(millis()>(57000+startingTime))){
    xWinnerHorse = xWinnerHorse+ 2;
  }

  return xWinnerHorse;
}

int secondHorse(){
  if ((millis()<(13000+startingTime))&&(millis()>(6000+startingTime))){
    xSecondHorse = xSecondHorse + 2;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(13000+startingTime))){
    xSecondHorse = xSecondHorse +1;
  } 
  if ((millis()<(27000+startingTime))&&(millis()>(15000+startingTime))){
    xSecondHorse = xSecondHorse -1;
  }
  if ((millis()<(290000+startingTime))&&(millis()>(27000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(35000+startingTime))&&(millis()>(29000+startingTime))){
    xSecondHorse = xSecondHorse +2;
  }
  if ((millis()<(39000+startingTime))&&(millis()>(29000+startingTime))){
    xSecondHorse = xSecondHorse -2;
  }
  if ((millis()<(47000+startingTime))&&(millis()>(39000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(65000+startingTime))&&(millis()>(53000+startingTime))){
    xSecondHorse = xSecondHorse +1;
  }

  return xSecondHorse;
}

int thirdHorse(){
  if ((millis()<(8000+startingTime))&&(millis()>(6000+startingTime))){
    xThirdHorse = xThirdHorse + 2;
  }
  if ((millis()<(13000+startingTime))&&(millis()>(8000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(14000+startingTime))&&(millis()>(7000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(14000+startingTime))){
    xThirdHorse = xThirdHorse +0;
  }
  if ((millis()<(20000+startingTime))&&(millis()>(18000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(24000+startingTime))&&(millis()>(20000+startingTime))){
    xThirdHorse = xThirdHorse +0;
  }
  if ((millis()<(26000+startingTime))&&(millis()>(24000+startingTime))){
    xThirdHorse = xThirdHorse -1;
  }
  if ((millis()<(30000+startingTime))&&(millis()>(26000+startingTime))){
    xThirdHorse = xThirdHorse -3;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(24000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(32000+startingTime))&&(millis()>(28000+startingTime))){
    xThirdHorse = xThirdHorse + 0;
  }
  if ((millis()<(37000+startingTime))&&(millis()>(32000+startingTime))){
    xThirdHorse = xThirdHorse + -1;
  }
  if ((millis()<(51000+startingTime))&&(millis()>(43000+startingTime))){
    xThirdHorse = xThirdHorse + 1;
  }
  if ((millis()<(49000+startingTime))&&(millis()>(45000+startingTime))){
    xThirdHorse = xThirdHorse -2;
  }
  if ((millis()<(54000+startingTime))&&(millis()>(49000+startingTime))){
    xThirdHorse = xThirdHorse -1;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(60000+startingTime))){      // "dies at 60-6 sec
    xThirdHorse = xThirdHorse -3;
  }
  if((millis()<(78000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xThirdHorse = xThirdHorse +3;
  }
  return xThirdHorse; 
}

int fourthHorse(){
  if ((millis()<(9000+startingTime))&&(millis()>(6000+startingTime))){
    xFourthHorse = xFourthHorse + 3;
  }
  if ((millis()<(5000+startingTime))&&(millis()>(3000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(11000+startingTime))){
    xFourthHorse = xFourthHorse - 2;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(12000+startingTime))){
    xFourthHorse = xFourthHorse -1;
  }
  if ((millis()<(28000+startingTime))&&(millis()>(24000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(31000+startingTime))&&(millis()>(28000+startingTime))){
    xFourthHorse = xFourthHorse + 2;
  }
  if ((millis()<(39000+startingTime))&&(millis()>(31000+startingTime))){
    xFourthHorse = xFourthHorse - 2;
  }
  if ((millis()<(42000+startingTime))&&(millis()>(39000+startingTime))){
    xFourthHorse = xFourthHorse + 3;
  }
  if ((millis()<(46000+startingTime))&&(millis()>(42000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(46000+startingTime))){      //dies
    xFourthHorse = xFourthHorse - 3;
  }  
  if((millis()<(85000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xFourthHorse = xFourthHorse +4;
  }
  return xFourthHorse; 
}

int lastHorse(){
  if ((millis()<(7000+startingTime))&&(millis()>(6000+startingTime))){
    xLastHorse = xLastHorse -2;
  }
  if ((millis()<(3000+startingTime))&&(millis()>(1000+startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(7000+startingTime))&&(millis()>(3000+startingTime))){
    xLastHorse = xLastHorse +2;
  }
  if ((millis()<(12000+startingTime))&&(millis()>(7000+startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(22000+startingTime))&&(millis()>(18000+startingTime))){
    xLastHorse = xLastHorse -3;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(16000+startingTime))){
    xLastHorse = xLastHorse -2;
  }
  if ((millis()<(29000+startingTime))&&(millis()>(24000+startingTime))){
    xLastHorse = xLastHorse +1;
  }
  if ((millis()<(66000+startingTime))&&(millis()>(29000+startingTime))){    //dies
    xLastHorse = xLastHorse -2;
  }
  if((millis()<(93000+startingTime))&&(millis()>(66000+startingTime))){      // finishline passing
    xLastHorse = xLastHorse +3;
  }
  return xLastHorse;
}
