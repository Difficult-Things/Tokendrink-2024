final int NUM_COLS = 8;
final int NUM_ROWS = 9;
final float PIN_SIZE = 35;
final float BALL_SIZE = 100;
final float GRAVITY = 0.1;
final float BOUNCINESS = 0.4;

PVector squareTopLeft, squareBottomRight;
PVector topLeft, bottomRight;
ArrayList<PVector> pins;
Ball ballPlinko;
boolean ballExists = false;
boolean start;
PImage backgroundImage; // Add a variable to hold the background image
boolean ballDropping = false;
int plinkoX = 800;
int plinkoDirection = 20;
int hitCounter = 0; // Counter to track hits on X = 635 line

float colSpacing; // Declare colSpacing as a global variable

int finishTime = 0;
static int finishRevealTime = 5000;

void resetPlinkoValues() {
  ballExists = false;
  ballDropping = false;
  plinkoX = 800;
  plinkoDirection = 20;
  hitCounter = 0; // Counter to track hits on X = 635 line
  finishTime = 0;
    ballPlinko.position.y = squareTopLeft.y+BALL_SIZE/2;

}

void setupPlinko() {
  //fullScreen();
  //size(1920,1080);
  backgroundImage = loadImage("slots_tokendrink_background.png");
  //background(backgroundImage);

  squareTopLeft = new PVector(120, 0);
  squareBottomRight = new PVector(1800, 1080);
  ballPlinko = new Ball(800, squareTopLeft.y+BALL_SIZE/2, BALL_SIZE);

  // Define the area for the Plinko game by setting the top-left and bottom-right coordinates
  // Adjust these coordinates to ensure the bottom right pin is placed with the desired spacing from the canvas edge
  topLeft = new PVector(150, 150); // Adjusted to provide a margin
  bottomRight = new PVector(1920-150, 2 * (1080 - 150)); // Adjusted to place the bottom-right pin correctly

  // Calculate the spacing based on the updated defined area and number of columns/rows
  colSpacing = (bottomRight.x - topLeft.x) / (NUM_COLS - 1);
  float rowSpacing = (bottomRight.y - topLeft.y) / ((NUM_ROWS - 1) / 2 * 3 + (NUM_ROWS - 1) % 2); // Adjusted for staggered rows

  pins = new ArrayList<PVector>();
  for (int row = 0; row < NUM_ROWS; row++) {
    int cols = row % 2 == 0 ? NUM_COLS : NUM_COLS - 1;
    for (int col = 0; col < cols; col++) {
      float x = topLeft.x + col * colSpacing + (row % 2 == 0 ? 0 : colSpacing / 2);
      float y = topLeft.y + row * rowSpacing * 2 / 3; // Adjust for staggered rows
      pins.add(new PVector(x, y));
    }
  }
}

//void draw() {
//  drawPlinko(start, 5, 4, 2, 3, 1);
//}



void drawPlinko(boolean start, int green, int purple, int orange, int blue, int red) {
  background(backgroundImage);
  noFill();
  noStroke();

  // Draw the rectangle
  float rectWidth = squareBottomRight.x - squareTopLeft.x;
  float rectHeight = squareBottomRight.y - squareTopLeft.y;
  rect(squareTopLeft.x, squareTopLeft.y, rectWidth, rectHeight);
  drawOdds(start, green, purple, orange, blue, red);

  // Draw the pins and the ball as before
  for (PVector pin : pins) {
    fill(#333333);
    circle(pin.x+1, pin.y+3, PIN_SIZE+3);
    fill(#B7A33F);
    circle(pin.x, pin.y, PIN_SIZE);
  }

  fill(#000000);
  rect(0, 0, 120+PIN_SIZE, 1080);
  rect(1920, 0, -120-PIN_SIZE, 1080);

  if (!ballDropping) {
    plinkoX = plinkoX += plinkoDirection;
    if (plinkoX > width-170 || plinkoX < 170) {
      plinkoDirection = -plinkoDirection;
    }

    ballPlinko.position.x = plinkoX;
    ballPlinko.display();

    // Check if the ball crosses X = 635 line
    if (plinkoX >= 635 && plinkoX <= 645 && start) {
      hitCounter++;
      if (hitCounter >= 2) {
        ballDropping = true;
        ballExists = true;
      }
    }
  }

  if (ballExists && ballDropping) {
    ballPlinko.update();
    ballPlinko.display();
    ballPlinko.checkCollision(pins, PIN_SIZE);
  }

  if (ballPlinko.position.y >= height - ballPlinko.radius - 5 && finishTime == 0) {
    finishTime = millis();
  }
  if (finishTime != 0 && millis() - finishTime > finishRevealTime) {
    int winningYear = -1;
    if (green == 1) {
      winningYear = 0;
    } else if (purple == 1) {
      winningYear = 1;
    } else if (orange == 1) {
      winningYear = 2;
    } else if (blue == 1) {
      winningYear = 3;
    } else if (red == 1) {
      winningYear = 4;
    }
    winningScreen(winningYear);
  }
}



class Ball {
  PVector position, velocity;
  float radius;

  Ball(float x, float y, float r) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    radius = r / 2; // Adjusted to use radius as a half-diameter for easier calculations
  }

  void update() {
    velocity.y += GRAVITY; // Apply gravity to the vertical velocity
    // Cap the velocity to simulate terminal velocity
    velocity.y = min(velocity.y, 10); // Example cap, adjust as needed
    position.add(velocity); // Update position based on velocity

    // Check for wall collisions and adjust velocity and position if necessary
    checkWallCollision();
  }

  void display() {
    fill(#333333);
    circle(position.x+1, position.y+3, (radius * 2)+3);

    fill(#fec00f);
    circle(position.x, position.y, radius * 2); // Draw ball with full diameter
  }

  void checkCollision(ArrayList<PVector> pins, float pinSize) {
    for (PVector pin : pins) {
      float d = PVector.dist(position, pin);
      if (d < (radius + pinSize / 2)) {
        PVector normal = PVector.sub(position, pin);
        normal.normalize();
        float dot = velocity.dot(normal);
        PVector reflectedVelocity = PVector.sub(velocity, PVector.mult(normal, 1.8 * dot));
        velocity.set(reflectedVelocity);
        position.add(PVector.mult(normal, (radius + pinSize / 2) - d));
      }
    }
  }

  void checkWallCollision() {
    // Left boundary
    if (position.x - radius < squareTopLeft.x) {
      position.x = squareTopLeft.x + radius;
      velocity.x *= -BOUNCINESS;
    }
    // Right boundary
    if (position.x + radius > squareBottomRight.x) {
      position.x = squareBottomRight.x - radius;
      velocity.x *= -BOUNCINESS;
    }
    // Top boundary
    if (position.y - radius < squareTopLeft.y) {
      position.y = squareTopLeft.y + radius;
      velocity.y *= -BOUNCINESS;
    }
    // Bottom boundary
    if (position.y + radius > squareBottomRight.y) {
      position.y = squareBottomRight.y - radius;
      velocity.y = 0;
      velocity.x = 0;
    }
  }
}


void drawOdds(boolean start, int green, int purple, int orange, int blue, int red) {
  fill(#EC681C);
  rect(120+PIN_SIZE+colSpacing*0, 1080, colSpacing, -60);
  fill(#009040);
  rect(120+PIN_SIZE+colSpacing*1, 1080, colSpacing, -60);
  if (green == 2) fill(#009040);
  else if (purple == 2) fill(#7724DE);
  else if (orange == 2) fill(#EC681C);
  else if (blue == 2) fill(#3280EA);
  else if (red == 2) fill(#BA0C2F);


  rect(120+PIN_SIZE+colSpacing*2, 1080, colSpacing, -60);
  if (green == 1) fill(#009040);
  else if (purple == 1) fill(#7724DE);
  else if (orange == 1) fill(#EC681C);
  else if (blue == 1) fill(#3280EA);
  else if (red == 1) fill(#BA0C2F);



  rect(120+PIN_SIZE+colSpacing*3, 1080, colSpacing, -60);
  fill(#BA0C2F);
  rect(120+PIN_SIZE+colSpacing*4, 1080, colSpacing, -60);
  fill(#7724DE);
  rect(120+PIN_SIZE+colSpacing*5, 1080, colSpacing, -60);
  fill(#3280EA);
  rect(120+PIN_SIZE+colSpacing*6, 1080, colSpacing, -60);
  fill(#BA0C2F);
}
