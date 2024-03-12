void startingBackground(){
  //ground
  background(#D38B53);
  
  //Sky
  fill(#53D4FA);
  rect(0,0,width,350);
  
  //startline
  stroke(0);
  strokeWeight(25);
  line(700, 350,540, height);
  
  strokeWeight(10);
  line(725,350,565,height);
  noStroke();
  
  image(background_clouds, 0, 60, 4000, 125);
  image(background_mountains, 0,50, 4000, 300);
  image(background_fence, -7, 200, 4000, 150);
  
}
