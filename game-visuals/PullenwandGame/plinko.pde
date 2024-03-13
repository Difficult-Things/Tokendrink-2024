final int plinkoCols = 7;
final int plinkoRows = 9;
int plinkoDropX = 450; // Changed to non-final to allow updating
final float plinkoPinSize = 6;
final float plinkoBallSize = 14;
final float plinkoGravity = 0.005;
final float plinkoBounciness = 0.0;
boolean plinkoBallExists = false;
int lastDropFrame = 0;
final int dropInterval = 5 * 60; // 5 seconds in frames (assuming 60 frames per second)
PVector plinkoBoundsTopLeft, plinkoBoundsBottomRight;
PVector plinkoTopLeft, plinkoBottomRight;
ArrayList<PVector> plinkoPins;
PlinkoBall plinkoBall;
boolean firstBall = false;


void setupPlinko() {
  size(1600, 400);
  noSmooth();
  noStroke();
  lights = new LightCanvas(this, "layout.json");

  plinkoBoundsTopLeft = new PVector(410, 20);
  plinkoBoundsBottomRight = new PVector(615, 170);

  plinkoTopLeft = new PVector(410, 44);
  plinkoBottomRight = new PVector(615, 280); // Adjusted to match original math

  float colSpacing = (plinkoBottomRight.x - plinkoTopLeft.x) / (plinkoCols - 1);
  float rowSpacing = (plinkoBottomRight.y - plinkoTopLeft.y) / ((plinkoRows - 1) / 2 * 3 + (plinkoRows - 1) % 2);

  plinkoPins = new ArrayList<PVector>();
  for (int row = 0; row < plinkoRows; row++) {
    int cols = row % 2 == 0 ? plinkoCols : plinkoCols - 1;
    for (int col = 0; col < cols; col++) {
      float x = plinkoTopLeft.x + col * colSpacing + (row % 2 == 0 ? 0 : colSpacing / 2);
      float y = plinkoTopLeft.y + row * rowSpacing * 2 / 3;
      plinkoPins.add(new PVector(x, y));
    }
  }
}

void drawPlinko() {
  fill(#000000);

  rect(0, 0, width, height);


  fill(#FF8D00); // Adjust color to your preference
  rect(390, 30, 240, 150);

  //fill(0); // Adjust color to your preference for pins
  noFill();
  for (PVector pin : plinkoPins) {
    ellipse(pin.x, pin.y, plinkoPinSize, plinkoPinSize);
  }

  // Draw plinko ball if exists
  if (plinkoBallExists) {
    plinkoBall.update();
    plinkoBall.display();
    plinkoBall.checkCollision(plinkoPins, plinkoPinSize);
  }
}

void dropBall() {
  plinkoDropX = int(random(plinkoBoundsTopLeft.x, plinkoBoundsBottomRight.x));
  plinkoBall = new PlinkoBall(plinkoDropX, plinkoBoundsTopLeft.y, plinkoBallSize);
  plinkoBallExists = true;
  lastDropFrame = frameCount; // Update the last drop frame
}

class PlinkoBall {
  PVector position, velocity;
  float radius;
  boolean hasLanded = false; // Track if the ball has landed

  PlinkoBall(float x, float y, float r) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    radius = r / 2;
  }

  void update() {
    if (!hasLanded) { // Only update if the ball hasn't landed
      velocity.y += plinkoGravity;
      velocity.y = min(velocity.y, 10);
      position.add(velocity);
      checkWallCollision();
    }
  }

  void display() {
    fill(#FFFFFF); // Adjust color to your preference
    ellipse(position.x, position.y, radius * 2, radius * 2);
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
    if (position.x - radius < plinkoBoundsTopLeft.x) {
      position.x = plinkoBoundsTopLeft.x + radius;
      velocity.x *= -plinkoBounciness;
    }
    if (position.x + radius > plinkoBoundsBottomRight.x) {
      position.x = plinkoBoundsBottomRight.x - radius;
      velocity.x *= -plinkoBounciness;
    }
    if (position.y - radius < plinkoBoundsTopLeft.y) {
      position.y = plinkoBoundsTopLeft.y + radius;
      velocity.y *= -plinkoBounciness;
    }
    // Check if the ball has hit the ground
    if (position.y + radius > plinkoBoundsBottomRight.y) {
      position.y = plinkoBoundsBottomRight.y - radius;
      velocity.y = 0; // Stop vertical movement
      velocity.x = 0; // Optionally stop horizontal movement as well
      hasLanded = true; // Mark the ball as landed
      delay(5000);
      dropBall();
    }
  }
}
