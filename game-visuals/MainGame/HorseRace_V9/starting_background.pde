void startingBackground(){
  //ground
  background(#D38B53);
  
  //Sky
  fill(#53D4FA);
  rect(0,0,width,350);
  
  //startline
  stroke(0);
  strokeWeight(25);
  line(400, 350, 240, height);
  
  strokeWeight(10);
  line(425,350,265,height);
  noStroke();
  
  image(background_clouds, 0, 60, 4000, 125);
  image(background_mountains, 0,50, 4000, 300);
  image(background_fence, -7, 200, 4000, 150);
  
  horseGreen(0);
  horsePurple(0);
  horseBlue(0);
  horseRed(0);
  horseOrange(0);
}
