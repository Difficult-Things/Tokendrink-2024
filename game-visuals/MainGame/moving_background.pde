//Start values
int xMountains = 0;
int xFence = 0;
int xClouds = 0;
int xStart = 0;
int xFinish = 1700;

void movingBackground(){  
  //ground
  background(#D38B53);
  
  //Sky
  fill(#53D4FA);
  rect(0,0,width,350);
  

  if ((millis()<(59000+startingTime))&&(millis()>(startingTime))){  
     if( xStart > -435){
       xStart = xStart - 4;
     }
     if (millis()>(47000+startingTime)&&(xStart<-430)){
       xStart = xFinish;
     }
    //clouds
    if (xClouds>(-4000+width)){
      xClouds=xClouds-1;
    }
    
    //mountains
    if (xMountains>(-4000+width)){
      xMountains=xMountains-2;
    }
    
    //Fence
    if (xFence>(-4000+7+width)){
      xFence=xFence-4;
    }
  } 
  //startline
  stroke(0);
  strokeWeight(25);
  line(xStart+400, 350, xStart+240, height);
  
  strokeWeight(10);
  line(xStart+425,350,xStart+265,height);
  noStroke();

  image(background_clouds, xClouds, 60, 4000, 125);
  image(background_mountains, xMountains,50, 4000, 300);
  image(background_fence, xFence-7, 200, 4000, 150);
  
  
  //textAlign(CENTER);
  //if ((millis()>(3000+startingTime))&& (millis()<(4000+startingTime))){
  //  fill(255);
  //  textSize(500);
  //  text("3", width/2, height/2);
  //}
  //  if ((millis()>(4000+startingTime))&& (millis()<(5000+startingTime))){
  //  fill(255);
  //  textSize(500);
  //  text("2", width/2, height/2);
  //}
  //  if ((millis()>(5000+startingTime))&& (millis()<(6000+startingTime))){
  //  fill(255);
  //  textSize(500);
  //  text("1", width/2, height/2);
  //}
}
