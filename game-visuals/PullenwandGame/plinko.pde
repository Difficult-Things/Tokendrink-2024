  final int plinkoNUM_COLS = 7;
  final int plinkoNUM_ROWS = 9;
  final float plinkoPIN_SIZE = 6;
  final float plinkoBALL_SIZE = 13;
  final float plinkoGRAVITY = 0.02;
  final float plinkoBOUNCINESS = 0.1; // Adjusted for realistic bounciness

  PVector plinkoSquareTopLeft, plinkoSquareBottomRight;
  ArrayList<PVector> plinkoPins;
  PlinkoBall plinkoBall;
  boolean plinkoBallExists = false;
  boolean plinkoBallDropped = false;


void setupPlinko() {
  // Define the area for the Plinko game by setting the top-left and bottom-right coordinates
  float plinkoRectWidth = 240; // Adjusted width
  float plinkoRectHeight = 160; // Adjusted height
  plinkoSquareTopLeft = new PVector(50, 50); // Adjusted coordinates
  plinkoSquareBottomRight = new PVector(plinkoSquareTopLeft.x + plinkoRectWidth, plinkoSquareTopLeft.y + plinkoRectHeight);

  // Calculate pin positions
  float plinkoColSpacing = plinkoRectWidth / (plinkoNUM_COLS - 1);
  float plinkoRowSpacing = plinkoRectHeight / ((plinkoNUM_ROWS - 1) / 2 * 3 + (plinkoNUM_ROWS - 1) % 2); // Adjusted for staggered rows

  plinkoPins = new ArrayList<PVector>();
  for (int plinkoRow = 0; plinkoRow < plinkoNUM_ROWS; plinkoRow++) {
    int plinkoCols = plinkoRow % 2 == 0 ? plinkoNUM_COLS : plinkoNUM_COLS - 1;
    for (int plinkoCol = 0; plinkoCol < plinkoCols; plinkoCol++) {
      float plinkoX = plinkoSquareTopLeft.x + plinkoCol * plinkoColSpacing + (plinkoRow % 2 == 0 ? 0 : plinkoColSpacing / 2);
      float plinkoY = plinkoSquareTopLeft.y + plinkoRow * plinkoRowSpacing * 2 / 3; // Adjust for staggered rows
      plinkoPins.add(new PVector(plinkoX, plinkoY));
    }
  }
  background(0);
}











void drawPlinko() {
  background(0);
  fill(0);
  noStroke();
  rect(plinkoSquareTopLeft.x, plinkoSquareTopLeft.y, plinkoSquareBottomRight.x - plinkoSquareTopLeft.x, plinkoSquareBottomRight.y - plinkoSquareTopLeft.y);

  fill(#FF0000);
  for (PVector plinkoPin : plinkoPins) {
    ellipse(plinkoPin.x, plinkoPin.y, plinkoPIN_SIZE, plinkoPIN_SIZE);
  }

  if (plinkoBallExists && plinkoBallDropped) {
    plinkoBall.update();
    plinkoBall.display();
    plinkoBall.checkCollision(plinkoPins, plinkoPIN_SIZE);
  }
  delay(2);
}

void plinkoMousePressed() {
  if (!plinkoBallDropped) {
    plinkoBall = new PlinkoBall((plinkoSquareTopLeft.x + plinkoSquareBottomRight.x) / 2, plinkoSquareTopLeft.y, plinkoBALL_SIZE); // Drop location set to the top-center
    plinkoBallExists = true;
    plinkoBallDropped = true;
  }
}

class PlinkoBall {
  PVector plinkoPosition, plinkoVelocity;
  float plinkoRadius;

  PlinkoBall(float plinkoX, float plinkoY, float plinkoR) {
    plinkoPosition = new PVector(plinkoX, plinkoY);
    plinkoVelocity = new PVector(0, 0);
    plinkoRadius = plinkoR / 2; // Adjusted to use radius as a half-diameter for easier calculations
  }

  void update() {
    plinkoVelocity.y += plinkoGRAVITY;
    plinkoVelocity.y = min(plinkoVelocity.y, 10);
    plinkoPosition.add(plinkoVelocity);
    checkWallCollision();
  }

  void display() {
    fill(255, 0, 255);
    ellipse(plinkoPosition.x, plinkoPosition.y, plinkoRadius * 2, plinkoRadius * 2);
  }

  void checkCollision(ArrayList<PVector> plinkoPins, float pinSize) {
    for (PVector plinkoPin : plinkoPins) {
      float plinkoD = PVector.dist(plinkoPosition, plinkoPin);
      if (plinkoD < (plinkoRadius + pinSize / 2)) {
        PVector plinkoNormal = PVector.sub(plinkoPosition, plinkoPin);
        plinkoNormal.normalize();
        float plinkoDot = plinkoVelocity.dot(plinkoNormal);
        PVector plinkoReflectedVelocity = PVector.sub(plinkoVelocity, PVector.mult(plinkoNormal, 2 * plinkoDot));
        plinkoVelocity.set(plinkoReflectedVelocity);
        plinkoPosition.add(PVector.mult(plinkoNormal, (plinkoRadius + pinSize / 2) - plinkoD));
      }
    }
  }

  void checkWallCollision() {
    if (plinkoPosition.x - plinkoRadius < plinkoSquareTopLeft.x) {
      plinkoPosition.x = plinkoSquareTopLeft.x + plinkoRadius;
      plinkoVelocity.x *= -plinkoBOUNCINESS;
    }
    if (plinkoPosition.x + plinkoRadius > plinkoSquareBottomRight.x) {
      plinkoPosition.x = plinkoSquareBottomRight.x - plinkoRadius;
      plinkoVelocity.x *= -plinkoBOUNCINESS;
    }
    if (plinkoPosition.y - plinkoRadius < plinkoSquareTopLeft.y) {
      plinkoPosition.y = plinkoSquareTopLeft.y + plinkoRadius;
      plinkoVelocity.y *= -plinkoBOUNCINESS;
    }
    if (plinkoPosition.y + plinkoRadius > plinkoSquareBottomRight.y) {
      plinkoPosition.y = plinkoSquareBottomRight.y - plinkoRadius;
      plinkoVelocity.y *= -plinkoBOUNCINESS;
    }
  }
}
