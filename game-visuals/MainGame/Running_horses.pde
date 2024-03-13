int xWinnerHorse = 0;
int xSecondHorse = 0;
int xThirdHorse = 0;
int xFourthHorse = 0;
int xLastHorse = 0;


int winningHorse(){
  if ((millis()<(4000+startingTime))&&(millis()>(startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(8000+startingTime))&&(millis()>(4000+startingTime))){
    xWinnerHorse = xWinnerHorse + 3;
  }
  if ((millis()<(15000+startingTime))&&(millis()>(8000+startingTime))){
  xWinnerHorse = xWinnerHorse +0;
  }
  if ((millis()<(22000+startingTime))&&(millis()>(15000+startingTime))){
  xWinnerHorse = xWinnerHorse - 1;
  }
  if ((millis()<(24000+startingTime))&&(millis()>(22000+startingTime))){
    xWinnerHorse = xWinnerHorse + 0;
  }
  if ((millis()<(29000+startingTime))&&(millis()>(24000+startingTime))){
    xWinnerHorse = xWinnerHorse + 4;
  }
  if ((millis()<(34000+startingTime))&&(millis()>(29000+startingTime))){
    xWinnerHorse = xWinnerHorse - 3;
  }
  if ((millis()<(36000+startingTime))&&(millis()>(34000+startingTime))){
    xWinnerHorse = xWinnerHorse -1;
  }
  if ((millis()<(42000+startingTime))&&(millis()>(36000+startingTime))){
    xWinnerHorse = xWinnerHorse + 3;
  }
  if ((millis()<(47000+startingTime))&&(millis()>(42000+startingTime))){
    xWinnerHorse = xWinnerHorse + 1;
  }
  if ((millis()<(51000+startingTime))&&(millis()>(47000+startingTime))){
   xWinnerHorse = xWinnerHorse + 0;
  }
  if ((millis()<(57000+startingTime))&&(millis()>(51000+startingTime))){
    xWinnerHorse = xWinnerHorse+ 2;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(57000+startingTime))){
   xWinnerHorse = xWinnerHorse + 4;
  }
  return xWinnerHorse;
}

int secondHorse(){
  if ((millis()<(7000+startingTime))&&(millis()>(startingTime))){
    xSecondHorse = xSecondHorse + 4;
  }
  if ((millis()<(9000+startingTime))&&(millis()>(7000+startingTime))){
    xSecondHorse = xSecondHorse +3;
  } 
  if ((millis()<(17000+startingTime))&&(millis()>(9000+startingTime))){
    xSecondHorse = xSecondHorse -2;
  }
  if ((millis()<(230000+startingTime))&&(millis()>(17000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(29000+startingTime))&&(millis()>(23000+startingTime))){
    xSecondHorse = xSecondHorse +3;
  }
  if ((millis()<(39000+startingTime))&&(millis()>(29000+startingTime))){
    xSecondHorse = xSecondHorse -2;
  }
  if ((millis()<(47000+startingTime))&&(millis()>(39000+startingTime))){
    xSecondHorse = xSecondHorse +0;
  }
  if ((millis()<(54000+startingTime))&&(millis()>(47000+startingTime))){
    xSecondHorse = xSecondHorse +2;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(54000+startingTime))){
    xSecondHorse = xSecondHorse +6;
  }
  return xSecondHorse;
}

int thirdHorse(){
  if ((millis()<(2000+startingTime))&&(millis()>(startingTime))){
    xThirdHorse = xThirdHorse + 3;
  }
  if ((millis()<(7000+startingTime))&&(millis()>(2000+startingTime))){
    xThirdHorse = xThirdHorse + 2;
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
  if ((millis()<(45000+startingTime))&&(millis()>(37000+startingTime))){
    xThirdHorse = xThirdHorse + 3;
  }
  if ((millis()<(49000+startingTime))&&(millis()>(45000+startingTime))){
    xThirdHorse = xThirdHorse -2;
  }
  if ((millis()<(54000+startingTime))&&(millis()>(49000+startingTime))){
    xThirdHorse = xThirdHorse -1;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(54000+startingTime))){      // "dies at 60-6 sec
    xThirdHorse = xThirdHorse -5;
  }
  if((millis()<(80000+startingTime))&&(millis()>(60000+startingTime))){      // finishline passing
    xThirdHorse = xThirdHorse +3;
  }
  return xThirdHorse; 
}

int fourthHorse(){
  if ((millis()<(3000+startingTime))&&(millis()>(startingTime))){
    xFourthHorse = xFourthHorse + 5;
  }
  if ((millis()<(5000+startingTime))&&(millis()>(3000+startingTime))){
    xFourthHorse = xFourthHorse + 1;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(5000+startingTime))){
    xFourthHorse = xFourthHorse - 3;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(12000+startingTime))){
    xFourthHorse = xFourthHorse -1;
  }
  if ((millis()<(22000+startingTime))&&(millis()>(18000+startingTime))){
    xFourthHorse = xFourthHorse + 2;
  }
  if ((millis()<(25000+startingTime))&&(millis()>(22000+startingTime))){
    xFourthHorse = xFourthHorse + 4;
  }
  if ((millis()<(33000+startingTime))&&(millis()>(25000+startingTime))){
    xFourthHorse = xFourthHorse - 3;
  }
  if ((millis()<(36000+startingTime))&&(millis()>(33000+startingTime))){
    xFourthHorse = xFourthHorse + 5;
  }
  if ((millis()<(40000+startingTime))&&(millis()>(36000+startingTime))){
    xFourthHorse = xFourthHorse + 2;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(40000+startingTime))){      //dies
    xFourthHorse = xFourthHorse - 5;
  }  
  if((millis()<(96000+startingTime))&&(millis()>(60000+startingTime))){      // finishline passing
    xFourthHorse = xFourthHorse +4;
  }
  return xFourthHorse; 
}

int lastHorse(){
  if ((millis()<(1000+startingTime))&&(millis()>(startingTime))){
    xLastHorse = xLastHorse -5;
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
  if ((millis()<(16000+startingTime))&&(millis()>(12000+startingTime))){
    xLastHorse = xLastHorse -4;
  }
  if ((millis()<(18000+startingTime))&&(millis()>(16000+startingTime))){
    xLastHorse = xLastHorse -2;
  }
  if ((millis()<(23000+startingTime))&&(millis()>(18000+startingTime))){
    xLastHorse = xLastHorse +3;
  }
  if ((millis()<(60000+startingTime))&&(millis()>(23000+startingTime))){    //dies
    xLastHorse = xLastHorse -5;
  }
  if((millis()<(138000+startingTime))&&(millis()>(60000+startingTime))){      // finishline passing
    xLastHorse = xLastHorse +3;
  }
  return xLastHorse;
}
