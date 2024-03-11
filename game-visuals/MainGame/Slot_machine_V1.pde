PImage[] imagesSlots = new PImage[10];
int currentIndex = 0;
int timer = 0;
int interval = 80; // Time interval between image changes
int stopTime = 3000; // Time in milliseconds after which spinning stops
int waitTime = 1000; // 1 second wait time after aligning and before next spin
long startWaitTime = 0; // To track when we started waiting
int spinning = 1; // Flag to control spinning
int row = 0;
PImage imgSlot;
PImage backgroundSlots;

int spinningCount = 0;
int winnerImage = 0;

int[] currentIndexes = new int[]{0, 0, 0, 0, 0};


int[] firstRound = new int[]{2, 2, 8, 2, 4};
int[] secondRound = new int[]{2, 2, 2, 2, 4};
int[] thirthRound;

void resetSlotValues() {
  currentIndex = 0;
  timer = 0;
  startWaitTime = 0; // To track when we started waiting
  spinning = 1; // Flag to control spinning
  row = 0;
  spinningCount = 0;
  winnerImage = 0;
}

void setupSlots() {
  imgSlot = loadImage("image_slot_nobg.png");
  backgroundSlots = loadImage("slots_tokendrink_background.png");
  for (int i = 0; i < imagesSlots.length; i++) {
    imagesSlots[i] = loadImage("slot_image_" + i + ".png");
  }
}

void drawSlots(boolean start, int green, int purple, int orange, int blue, int red) {
  pushStyle();
  imageMode(CENTER);

  background(255);
  image(backgroundSlots, width / 2, height / 2);
  pushStyle();
  fill(255);
  rect(300,400,1300,400);
  popStyle();
  image(imgSlot, width / 2, height / 2);

  // Display images in fixed positions
  for (int i = 0; i < 5; i++) {
    image(imagesSlots[currentIndexes[i]], (width / 2 - 400) + 200 * i, height / 2, 200, 200);
  }

  if (green == 1) {
    winnerImage = 0;
  } else if (purple == 1) {
    winnerImage = 2;
  } else if (orange == 1) {
    winnerImage = 6;
  } else if (blue == 1) {
    winnerImage = 4;
  } else if (red == 1) {
    winnerImage = 8;
  }
  thirthRound = new int[]{winnerImage, winnerImage, winnerImage, winnerImage, winnerImage};

  // Spinning logic
  if (spinning == 1 && millis() - timer > interval) {
    timer = millis(); // Reset timer for spinning
    for (int i = 0; i < 5; i++) {
      currentIndexes[i] = (currentIndexes[i] + 1) % imagesSlots.length;
    }
  }

  if (start) {
    // Check if it's time to switch to the next round or stop spinning
    if (millis() > stopTime && spinning == 1) {
      spinning = 2; // Prepare to stop
    }

    //Stop spinning and align images according to the specified round
    if (spinning == 2 && spinningCount == 0) {
      alignImagesTo(firstRound);
    } else if (spinning == 2 && spinningCount == 1) {
      alignImagesTo(secondRound);
    } else if (spinning == 2 && spinningCount == 2) {
      alignImagesTo(thirthRound);
    }
  }
  popStyle();
}

void alignImagesTo(int[] round) {
  boolean aligned = true;
  for (int i = 0; i < 5; i++) {
    if (currentIndexes[i] != round[i]) {
      currentIndexes[i] = (currentIndexes[i] + 1) % imagesSlots.length;
      aligned = false;
      break; // Adjust one image at a time
    }
  }
  if (aligned && startWaitTime == 0) { // If just aligned, start wait timer
    startWaitTime = millis();
  }

  if (aligned && millis() - startWaitTime < waitTime) {
    // Just wait, do nothing yet
    return;
  }

  if (aligned && millis() - startWaitTime >= waitTime) {
    // Waited enough, proceed
    spinningCount++; // Prepare for next round or stop
    if (spinningCount < 3) {
      spinning = 1; // Restart spinning for next round
      timer = millis(); // Reset timer to start spinning immediately
      stopTime = millis() + 3000; // Reset stopTime for next round
    } else {
      spinning = 0; // Stop spinning after final round
    }
    startWaitTime = 0; // Reset wait timer
  }
}
