static int numSlots = 36; // Number of slots on the roulette wheel
float angleBetweenSlots; // Angle between each slot
static float wheelRadius = 200; // Radius of the roulette wheel
float ballRadius = 10; // Radius of the ball

float wheelAngle = 0; // Initial angle of the wheel
float ballAngle = 0; // Initial angle of the ball
float ballSpeed = radians(2); // Initial speed of the ball
float ballRotation = 0; // Rotation of the ball
boolean spinningRoulette = false; // Flag to indicate if the wheel is spinning

int landedNumber = -1; // Number where the ball has landed

float landedBallSize = 10; // Initial size of the landed ball
float maxSize = 100; // Maximum size of the landed ball
boolean animationStarted = false; // Flag to indicate if the animation has started

int spinStartTime; // Variable to store the time when the spinning started

PImage chipImageBlue; // Declare a PImage variable
PImage chipImageRed; // Declare a PImage variable
PImage chipImageGreen; // Declare a PImage variable
PImage chipImagePurple; // Declare a PImage variable
PImage chipImageOrange; // Declare a PImage variable
PImage background; // Declare a PImage variable

int numImages = 50; // Number of images to fall
float[] imageX, imageY; // Arrays to store image positions
float speed = 25; // Initial speed of falling images

//animation don't start, begin animation does start inmediattely
boolean animationStartedRed = false;
boolean animationStartedPurple = false;
boolean animationStartedBlue = false;
boolean animationStartedGreen = false;
boolean animationStartedOrange = false;
boolean beginanimation = true;
boolean rouletteStartedSpinning = false;
int count = 0;

int winningnumber; //used for final animation

static int redNumber = 1;
static int greenNumber = 2;
static int purpleNumber = 3;
static int orangeNumber = 4;
static int blueNumber = 5;

//numbers of the layout board
int[][] numbers = {
  {3, color(255, 0, 0), 0}, {6, color(0, 0, 0), 0}, // Red
  {9, color(255, 0, 0), 0}, {12, color(255, 0, 0), 0}, {15, color(0, 0, 0), 0}, // Black
  {18, color(255, 0, 0), 0}, {21, color(255, 0, 0), 0}, {24, color(0, 0, 0), 0}, // Red
  {27, color(255, 0, 0), 0}, {30, color(255, 0, 0), 0}, {33, color(0, 0, 0), 0}, // Black
  {36, color(255, 0, 0), 0}, {2, color(0, 0, 0), 0}, {5, color(255, 0, 0), 0}, // Red
  {8, color(0, 0, 0), 0}, {11, color(0, 0, 0), 0}, {14, color(255, 0, 0), 0}, // Black
  {17, color(0, 0, 0), 0}, {20, color(0, 0, 0), 0}, {23, color(255, 0, 0), 0}, // Red
  {26, color(0, 0, 0), 0}, {29, color(0, 0, 0), 0}, {32, color(255, 0, 0), 0}, // Black
  {35, color(0, 0, 0), 0}, {1, color(255, 0, 0), 0}, {4, color(0, 0, 0), 0}, // Red
  {7, color(255, 0, 0), 0}, {10, color(0, 0, 0), 0}, {13, color(0, 0, 0), 0}, // Black
  {16, color(255, 0, 0), 0}, {19, color(255, 0, 0), 0}, {22, color(0, 0, 0), 0}, // Red
  {25, color(255, 0, 0), 0}, {28, color(0, 0, 0), 0}, {31, color(0, 0, 0), 0}, // Red
  {34, color(255, 0, 0), 0}
};

//nunbers of the wheel
int[][] numbers2 = {
  {0, color(0, 128, 0)}, // Green for 0
  {32, color(255, 0, 0)}, {15, color(0, 0, 0)}, {19, color(255, 0, 0)}, // Black
  {4, color(0, 0, 0)}, {21, color(255, 0, 0)}, {2, color(0, 0, 0)}, // Red
  {25, color(255, 0, 0)}, {17, color(0, 0, 0)}, {34, color(255, 0, 0)}, // Black
  {6, color(0, 0, 0)}, {27, color(255, 0, 0)}, {13, color(0, 0, 0)}, // Red
  {36, color(255, 0, 0)}, {11, color(0, 0, 0)}, {30, color(255, 0, 0)}, // Red
  {8, color(0, 0, 0)}, {23, color(255, 0, 0)}, {10, color(0, 0, 0)}, // Black
  {5, color(255, 0, 0)}, {24, color(0, 0, 0)}, {16, color(255, 0, 0)}, // Red
  {33, color(0, 0, 0)}, {1, color(255, 0, 0)}, {20, color(0, 0, 0)}, // Red
  {14, color(255, 0, 0)}, {31, color(0, 0, 0)}, {9, color(255, 0, 0)}, // Red
  {22, color(0, 0, 0)}, {18, color(255, 0, 0)}, {29, color(0, 0, 0)}, // Red
  {7, color(255, 0, 0)}, {28, color(0, 0, 0)}, {12, color(255, 0, 0)}, // Red
  {35, color(0, 0, 0)}, {3, color(255, 0, 0)}, {26, color(0, 0, 0)}  // Red
};

//positions of the chips placed
int[][] positions = new int[][]{{20, 10, 30, 29, 16, 13, 14, 6, 7, 34}, {5, 24, 1, 2, 12, 9, 31, 17, 23}, {28, 32, 3, 8, 34, 0, 19}, {21, 22, 33, 11, 18, 15}, {35, 25, 26, 27, 4}};

void resetRouletteValues() {
  wheelAngle = 0; // Initial angle of the wheel
  ballAngle = 0; // Initial angle of the ball
  ballSpeed = radians(2); // Initial speed of the ball
  ballRotation = 0; // Rotation of the ball
  spinningRoulette = false; // Flag to indicate if the wheel is spinning

  landedNumber = -1; // Number where the ball has landed

  landedBallSize = 10; // Initial size of the landed ball
  maxSize = 100; // Maximum size of the landed ball
  animationStarted = false; // Flag to indicate if the animation has started

  numImages = 50; // Number of images to fall
  speed = 25; // Initial speed of falling images

  //animation don't start, begin animation does start inmediattely
  animationStartedRed = false;
  animationStartedPurple = false;
  animationStartedBlue = false;
  animationStartedGreen = false;
  animationStartedOrange = false;
  beginanimation = true;
  rouletteStartedSpinning = false;
  count = 0;
  startRevealTime = 0;

  
numbers = new int[][]{
  {3, color(255, 0, 0), 0}, {6, color(0, 0, 0), 0}, // Red
  {9, color(255, 0, 0), 0}, {12, color(255, 0, 0), 0}, {15, color(0, 0, 0), 0}, // Black
  {18, color(255, 0, 0), 0}, {21, color(255, 0, 0), 0}, {24, color(0, 0, 0), 0}, // Red
  {27, color(255, 0, 0), 0}, {30, color(255, 0, 0), 0}, {33, color(0, 0, 0), 0}, // Black
  {36, color(255, 0, 0), 0}, {2, color(0, 0, 0), 0}, {5, color(255, 0, 0), 0}, // Red
  {8, color(0, 0, 0), 0}, {11, color(0, 0, 0), 0}, {14, color(255, 0, 0), 0}, // Black
  {17, color(0, 0, 0), 0}, {20, color(0, 0, 0), 0}, {23, color(255, 0, 0), 0}, // Red
  {26, color(0, 0, 0), 0}, {29, color(0, 0, 0), 0}, {32, color(255, 0, 0), 0}, // Black
  {35, color(0, 0, 0), 0}, {1, color(255, 0, 0), 0}, {4, color(0, 0, 0), 0}, // Red
  {7, color(255, 0, 0), 0}, {10, color(0, 0, 0), 0}, {13, color(0, 0, 0), 0}, // Black
  {16, color(255, 0, 0), 0}, {19, color(255, 0, 0), 0}, {22, color(0, 0, 0), 0}, // Red
  {25, color(255, 0, 0), 0}, {28, color(0, 0, 0), 0}, {31, color(0, 0, 0), 0}, // Red
  {34, color(255, 0, 0), 0}
};
}

void setupRoulette() {

  angleBetweenSlots = TWO_PI / numSlots;

  chipImageBlue = loadImage("BlueToken.png");
  chipImageOrange = loadImage("OrangeToken.png");
  chipImageRed = loadImage("RedToken.png");
  chipImageGreen = loadImage("GreenToken.png");
  chipImagePurple = loadImage("PurpleToken.png");
  background = loadImage("Board.png");

  // Initialize arrays
  imageX = new float[numImages];
  imageY = new float[numImages];

  // Fill arrays with initial values
  for (int i = 0; i < numImages; i++) {
    imageX[i] = random(-3500, 3200);
    imageY[i] = random(-1000, 0); // Start above the window
  }
}

void drawRoulette(boolean start, boolean reveal, int green, int purple, int orange, int blue, int red) {
  background(16, 120, 35);
  if (!start && !reveal) {
    drawFallingImagesSlow();
  }
  drawWheel();
  drawBettingLayout();
  drawZeroRectangle();

  if (start && !reveal && !rouletteStartedSpinning) {
    animationStartedOrange = false; //This one is supposedly still on
    rouletteStartedSpinning = true;
    spinningRoulette = true;
    spinStartTime = millis();
    //ballSpeed = radians(random(8, 12));
    ballSpeed = radians(12);

    animationStarted = false;
    landedBallSize = 10;
  }

  if (spinningRoulette) {
    spinWheel();
    spinBall();
  } else {
    // If the wheel has stopped spinning, display the landed number
    landedNumber = calculateLandedNumber();
    if (millis() - spinStartTime > 3000) { // Adjust the delay time as needed (2000 milliseconds in this example)
    count = 7; //IDK why this number anymore, was some logic behind it please kill me now (this was gino btw)
      displayLandedBallAnimation(winningnumber);
      
    }
  }

  drawBall();

  // Draw chips on the betting layout
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i][2] == blueNumber) {
      drawChipOnNumber(i, blueNumber);
    } else if (numbers[i][2] == redNumber) {
      drawChipOnNumber(i, redNumber);
      //image(chipImageRed, 269, -10, 40, 40); // Adjust the size of the image as needed
    } else if (numbers[i][2] == greenNumber) {
      drawChipOnNumber(i, greenNumber);
    } else if (numbers[i][2] == orangeNumber) {
      drawChipOnNumber(i, orangeNumber);
    } else if (numbers[i][2] == purpleNumber) {
      drawChipOnNumber(i, purpleNumber);
    }
  }
  if (!start && reveal) {
    revealRoulette(green, purple, orange, blue, red);
  }

  if (animationStartedRed) {
    drawFallingImagesRed();
  }
  if (animationStartedPurple) {
    drawFallingImagesPurple();
  }
  if (animationStartedBlue) {
    drawFallingImagesBlue();
  }
  if (animationStartedGreen) {
    drawFallingImagesGreen();
  }
  if (animationStartedOrange) {
    drawFallingImagesOrange();
  }
}

//reveal the red chips on the board, redPos decides the winning color
void revealred(int redPos) {
  int[] redIndexes = positions[redPos-1];

  for (int i = 0; i < redIndexes.length; i++) {

    numbers[redIndexes[i]][2] = redNumber;
  }
  if (redPos == 1) {
    winningnumber = 1;
  }
}

//reveal the purlpe chips on the board, purplePos decides the winning color
void revealpurple(int purplePos) {
  int[] purpleIndexes = positions[purplePos-1];

  for (int i = 0; i < purpleIndexes.length; i++) {

    numbers[purpleIndexes[i]][2] = purpleNumber;
  }
  if (purplePos == 1) {
    winningnumber = 2;
  }
}

//reveal the blue chips on the board, bluePos decides the winning color
void revealblue(int bluePos) {
  int[] blueIndexes = positions[bluePos-1];

  for (int i = 0; i < blueIndexes.length; i++) {

    numbers[blueIndexes[i]][2] = blueNumber;
  }
  if (bluePos == 1) {
    winningnumber = 3;
  }
}

//reveal the green chips on the board, greenPos decides the winning color
void revealgreen(int greenPos) {
  int[] greenIndexes = positions[greenPos-1];

  for (int i = 0; i < greenIndexes.length; i++) {

    numbers[greenIndexes[i]][2] = greenNumber;
  }
  if (greenPos == 1) {
    winningnumber = 4;
  }
}

//reveal the orange chips on the board, orangePos decides the winning color
void revealorange(int orangePos) {
  int[] orangeIndexes = positions[orangePos-1];

  for (int i = 0; i < orangeIndexes.length; i++) {

    numbers[orangeIndexes[i]][2] = orangeNumber;
  }
  if (orangePos == 1) {
    winningnumber = 5;
  }
}

//drawing of the richt chip on the right place in the field
void drawChipOnNumber(int index, int yearColor) {
  float x = (index % 12) * (width / 25) + 315 + (width / 25) / 2;
  float y = floor(index / 12) * (height / 15) - 100 + (height / 15) / 2;

  noStroke();
  if (yearColor == redNumber) {
    image(chipImageRed, x - 20, y - 20, 40, 40); // Adjust the size of the image as needed
  } else if (yearColor == blueNumber) {
    image(chipImageBlue, x - 20, y - 20, 40, 40); // Adjust the size of the image as needed
  } else if (yearColor == orangeNumber) {
    image(chipImageOrange, x - 20, y - 20, 40, 40); // Adjust the size of the image as needed
  } else if (yearColor == greenNumber) {
    image(chipImageGreen, x - 20, y - 20, 40, 40); // Adjust the size of the image as needed
  } else if (yearColor == purpleNumber) {
    image(chipImagePurple, x - 20, y - 20, 40, 40); // Adjust the size of the image as needed
  }
}

//draw the turning wheel
void drawWheel() {
  translate(width / 4 -40, height / 2+5);

  for (int i = 0; i < numSlots; i++) {
    float startAngle = i * angleBetweenSlots;
    float endAngle = (i + 1) * angleBetweenSlots;

    // Set color based on the number (even, odd, or 0)
    if (i == 0) {
      fill(0, 128, 0); // Green for 0
    } else if (i % 2 == 0) {
      fill(0); // Black for even numbers
    } else {
      fill(255, 0, 0); // Red for odd numbers
    }

    // Draw colored section
    arc(0, 0, wheelRadius * 2, wheelRadius * 2, startAngle, endAngle);

    // Draw number in the middle of the section
    pushMatrix();
    rotate(startAngle + angleBetweenSlots / 2);
    translate(wheelRadius * 0.8, 0); // Adjust the distance from the center
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(numbers2[i][0], 0, 0); // Draw number
    popMatrix();
  }
}

//draw ball that turns around the wheel
void drawBall() {
  float x = wheelRadius * cos(wheelAngle + ballAngle);
  float y = wheelRadius * sin(wheelAngle + ballAngle);

  // Apply rolling rotation to the ball
  pushMatrix();
  translate(x, y);
  rotate(ballRotation);
  fill(255);
  ellipse(0, 0, ballRadius * 2, ballRadius * 2);
  popMatrix();
}

//checks if the wheel is spinning
void spinWheel() {
  wheelAngle += radians(2); // Adjust the wheel spin speed as needed

  if (wheelAngle >= TWO_PI) {
    wheelAngle = 0;
    spinningRoulette = false;
  }
}

//the spinning of the ball around the wheel
void spinBall() {
  if (ballSpeed > 0) {
    ballAngle += ballSpeed; // Move in the initial direction
    ballRotation += ballSpeed / wheelRadius; // Apply rolling rotation
  } else {
    ballAngle -= ballSpeed / 2; // Move in the opposite direction (slower)
    ballRotation -= ballSpeed / (2 * wheelRadius); // Apply rolling rotation
  }

  // Decrease ball speed gradually to simulate slowing down
  ballSpeed *= 0.98;

  // If the ball has slowed down enough, stop the ball
  if (abs(ballSpeed) < 0.01) {
    ballSpeed = 0;
  }
}

void displayLandedNumber() {
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Landed on: " + landedNumber, 550, 250);
}

int calculateLandedNumber() {
  // Calculate the landed number based on the current ball angle
  int landedNumber = floor(map((TWO_PI - ballAngle) % TWO_PI, 0, TWO_PI, 0, numSlots)) - (2 * floor(map((TWO_PI - ballAngle) % TWO_PI, 0, TWO_PI, 0, numSlots))) - 1;
  // Assuming landedNumber is the variable holding the original order number
  switch (landedNumber) {
  case 0:
    landedNumber = 0;
    break;
  case 1:
    landedNumber = 32;
    break;
  case 2:
    landedNumber = 15;
    break;
  case 3:
    landedNumber = 19;
    break;
  case 4:
    landedNumber = 4;
    break;
  case 5:
    landedNumber = 21;
    break;
  case 6:
    landedNumber = 2;
    break;
  case 7:
    landedNumber = 25;
    break;
  case 8:
    landedNumber = 17;
    break;
  case 9:
    landedNumber = 34;
    break;
  case 10:
    landedNumber = 6;
    break;
  case 11:
    landedNumber = 27;
    break;
  case 12:
    landedNumber = 13;
    break;
  case 13:
    landedNumber = 36;
    break;
  case 14:
    landedNumber = 11;
    break;
  case 15:
    landedNumber = 30;
    break;
  case 16:
    landedNumber = 8;
    break;
  case 17:
    landedNumber = 23;
    break;
  case 18:
    landedNumber = 10;
    break;
  case 19:
    landedNumber = 5;
    break;
  case 20:
    landedNumber = 24;
    break;
  case 21:
    landedNumber = 16;
    break;
  case 22:
    landedNumber = 33;
    break;
  case 23:
    landedNumber = 1;
    break;
  case 24:
    landedNumber = 20;
    break;
  case 25:
    landedNumber = 14;
    break;
  case 26:
    landedNumber = 31;
    break;
  case 27:
    landedNumber = 9;
    break;
  case 28:
    landedNumber = 22;
    break;
  case 29:
    landedNumber = 18;
    break;
  case 30:
    landedNumber = 29;
    break;
  case 31:
    landedNumber = 7;
    break;
  case 32:
    landedNumber = 28;
    break;
  case 33:
    landedNumber = 12;
    break;
  case 34:
    landedNumber = 35;
    break;
  case 35:
    landedNumber = 3;
    break;
  case 36:
    landedNumber = 26;
    break;
  default:
    // Handle the case where landedNumber doesn't match any expected value
    break;
  }

  return landedNumber;
}

//show animation of the winning ball and the winning color
void displayLandedBallAnimation(int winning) {
  // Increase the size of the landed ball until it reaches the maximum size
  if (landedBallSize < maxSize) {
    landedBallSize += 1.8; // Adjust the speed of size increase as needed
  }

  // Draw the landed ball with the color of the slot
  int landedColor = getLandedColor(landedNumber);
  fill(landedColor);
  noStroke();
  ellipse(0, 0, max(landedBallSize, ballRadius) * 2, max(landedBallSize, ballRadius) * 2);


  // Once the ball stops growing, display the landed number inside the ball
  if (landedBallSize >= maxSize && landedNumber >=0) {
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(landedNumber, 0, 0);

    //if Red is winning, red coins will fly down. These appear when you click once more after spinning
    if (winning == 1 && count==7) {
      for (int i = 0; i < numImages; i++) {
        numImages = 40;
        imageY[i] += speed * 0.5; // Adjust the speed as needed (slower)
        image(chipImageRed, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
        image(chipImageRed, imageX[i]-600, imageY[i], 100, 100); // Adjust the size as needed

        if (imageY[i] > height) {
          imageY[i] = random(-1000, 0); // Reset the position above the window
        }
      }
    }

    //if Purple is winning, purple coins will fly down. These appear when you click once more after spinning
    if (winning == 2 && count==7) {
      for (int i = 0; i < numImages; i++) {
        numImages = 40;
        imageY[i] += speed * 0.5; // Adjust the speed as needed (slower)
        image(chipImagePurple, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
        image(chipImagePurple, imageX[i]-600, imageY[i], 100, 100); // Adjust the size as needed

        if (imageY[i] > height) {
          imageY[i] = random(-1000, 0); // Reset the position above the window
        }
      }
    }

    //if Blue is winning, blue coins will fly down. These appear when you click once more after spinning
    if (winning == 3 && count==7) {

      for (int i = 0; i < numImages; i++) {
        numImages = 40;
        imageY[i] += speed * 0.5; // Adjust the speed as needed (slower)
        image(chipImageBlue, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
        image(chipImageBlue, imageX[i]-600, imageY[i], 100, 100); // Adjust the size as needed

        if (imageY[i] > height) {
          imageY[i] = random(-1000, 0); // Reset the position above the window
        }
      }
    }

    //if Green is winning, green coins will fly down. These appear when you click once more after spinning
    if (winning == 4 && count==7) {
      for (int i = 0; i < numImages; i++) {
        numImages = 40;
        imageY[i] += speed * 0.5; // Adjust the speed as needed (slower)
        image(chipImageGreen, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
        image(chipImageGreen, imageX[i]-600, imageY[i], 100, 100); // Adjust the size as needed

        if (imageY[i] > height) {
          imageY[i] = random(-1000, 0); // Reset the position above the window
        }
      }
    }

    //if Orange is winning, orange coins will fly down. These appear when you click once more after spinning
    if (winning == 5 && count==7) {
      for (int i = 0; i < numImages; i++) {
        numImages = 40;
        imageY[i] += speed * 0.5; // Adjust the speed as needed (slower)
        image(chipImageOrange, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
        image(chipImageOrange, imageX[i]-600, imageY[i], 100, 100); // Adjust the size as needed

        if (imageY[i] > height) {
          imageY[i] = random(-1000, 0); // Reset the position above the window
        }
      }
    }

    for (int i = 0; i < numbers2.length; i++) {
      if (numbers2[i][0] == landedNumber) {
        text(numbers2[i][0], 0, 0); // Display the landed number inside the ball
        break;
      }
    }
  }

  animationStarted = true;
}

int getLandedColor(int number) {
  // Loop through the array to find the color associated with the landed number
  for (int i = 0; i < numbers2.length; i++) {
    if (numbers2[i][0] == number) {
      return numbers2[i][1]; // Return the color of the slot
    }
  }
  return color(255, 0, 0, 0); // Default to invisible to not show it when the wheel is not turning
}

//button for spinning


// animation for the beginning, tokens falling down slowly
void drawFallingImagesSlow() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    numImages=20;
    imageY[i] += speed * 0.2; // Adjust the speed as needed (slower)
    image(chipImageRed, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
    image(chipImageBlue, imageX[i]-100, imageY[i]+ 250, 100, 100); // Adjust the size as needed
    image(chipImagePurple, imageX[i] + 200, imageY[i] - 500, 100, 100); // Adjust the size as needed
    image(chipImageGreen, imageX[i] - 300, imageY[i] + 200, 100, 100); // Adjust the size as needed
    image(chipImageOrange, imageX[i]+ 200, imageY[i] - 200, 100, 100); // Adjust the size as needed

    if (imageY[i] > height) {
      imageY[i] = random(-1000, 0); // Reset the position above the window
    }
  }
}

//voids for the tokens falling down, after these have fallen, the fiches will show on the board
void drawFallingImagesRed() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    imageY[i] += speed; // Adjust the speed as needed
    image(chipImageRed, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
  }
}

void drawFallingImagesPurple() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    imageY[i] += speed; // Adjust the speed as needed
    image(chipImagePurple, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
  }
}

void drawFallingImagesBlue() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    imageY[i] += speed; // Adjust the speed as needed
    image(chipImageBlue, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
  }
}

void drawFallingImagesGreen() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    imageY[i] += speed; // Adjust the speed as needed
    image(chipImageGreen, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
  }
}

void drawFallingImagesOrange() {
  // Update and draw falling images
  for (int i = 0; i < numImages; i++) {
    imageY[i] += speed; // Adjust the speed as needed
    image(chipImageOrange, imageX[i], imageY[i], 100, 100); // Adjust the size as needed
  }
}



int startRevealTime = 0;
static int revealDelay = 5000;

void revealRoulette(int green, int purple, int orange, int blue, int red) {
  if (startRevealTime == 0) {
    startRevealTime = millis();
    if (!spinningRoulette && count == 1) {
      beginanimation = false;
    }
  }
  if (!animationStartedRed && millis() - startRevealTime < revealDelay * 1) {
    animationStartedRed = true;
    resetFallingImagePositions();
    revealred(red); //enter here the position of red
  }


  //third time you click, the purple fiches will show
  if (millis() - startRevealTime >= revealDelay * 1 && millis() - startRevealTime < revealDelay * 2 && !animationStartedPurple) {
    animationStartedRed = false;
    animationStartedPurple = true;
    resetFallingImagePositions();
    revealpurple(purple); //enter here the position of purple
  }


  if (millis() - startRevealTime >= revealDelay * 2 && millis() - startRevealTime < revealDelay * 3&& !animationStartedBlue) {
    animationStartedPurple = false;
    //fourth time you click, the blue fiches will show
    animationStartedBlue = true;
    resetFallingImagePositions();
    revealblue(blue); //enter here the position of blue
  }
  if (millis() - startRevealTime >= revealDelay * 3 && millis() - startRevealTime < revealDelay * 4&& !animationStartedGreen) {
    animationStartedBlue = false;
    //fifth time you click, the green fiches will show
    animationStartedGreen = true;
    resetFallingImagePositions();
    revealgreen(green); //enter here the position of green
  }
  if (millis() - startRevealTime >= revealDelay * 4 && !animationStartedOrange) {
    animationStartedGreen = false;
    //sixth time you click, the orange fiches will show
    animationStartedOrange = true;
    resetFallingImagePositions();
    revealorange(orange); //enter here the position of orange
  }
}

void resetFallingImagePositions() {
  // Reset the starting positions of falling images
  for (int i = 0; i < numImages; i++) {
    numImages=50;
    imageX[i] = random(200, 1200);
    imageY[i] = random(-1000, 0);
  }
}

//draw the betting layout on the right
void drawBettingLayout() {
  float cellWidth = width / 25;
  float cellHeight = height / 15;

  for (int i = 0; i < numbers.length; i++) {
    float x = (i % 12) * cellWidth + 315;
    float y = floor(i / 12) * cellHeight - 100;

    drawNumberCell(x, y, cellWidth, cellHeight, numbers[i][0], numbers[i][1]);
  }
}

//draw the right cells
void drawNumberCell(float x, float y, float w, float h, int number, color cellColor) {
  fill(cellColor);
  stroke(255);  // White stroke color
  rect(x, y, w, h);

  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(Integer.toString(number), x + w / 2, y + h / 2);
}

//draw the zero button on the draw layout
void drawZeroRectangle() {
  float zeroWidth = width / 25;
  float zeroHeight = height / 15 * 3;  // Same height as the total grid height

  fill(color(7, 61, 17));  // Green color for "0"
  stroke(255);  // White stroke color
  rect(250, -100, zeroWidth, zeroHeight);

  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("0", 250 + zeroWidth / 2, -100 + zeroHeight / 2);
}
