final int MIN_LENGTH = 10;
final color BG_COLOR = color(64, 64, 64);
color FILL_COLOR = color(255, 255, 255);

float osX = 0, osY = 0, zoom = 1, actualZoom = 1, aOsX = 0, aOsY = 0;
float pmX = 0, pmY = 0, time = 0;

float breathingAmount = 127;

void setup() {
  size(512, 512);
}

void draw() {
  actualZoom = lerp(actualZoom, zoom, 0.1);
  aOsX = lerp(aOsX, osX, 0.2);
  aOsY = lerp(aOsY, osY, 0.2);

  translate(aOsX, aOsY);
  scale(actualZoom);

  FILL_COLOR = color(sin(time) * breathingAmount + breathingAmount,
    sin(time + 0.5) * breathingAmount + breathingAmount,
    sin(time + 1.0) * breathingAmount + breathingAmount);
  time += 0.005;

  background(BG_COLOR);
  noStroke();
  drawFunnyTriangle(width / 2, 0, width);
}

void mousePressed() {
  pmX = mouseX;
  pmY = mouseY;
}

void mouseDragged() {
  osX += mouseX - pmX;
  osY += mouseY - pmY;
  pmX = mouseX;
  pmY = mouseY;
}

void keyPressed() {
  if (key == 'i') {
    zoom += 0.2;
  } else if (key == 'o') {
    zoom -= 0.2;
  }
  zoom = constrain(zoom, 0.5, 10);
}

void drawFunnyTriangle(int x, int y, int length) {
  if (length < MIN_LENGTH) {
    return;
  } else {
    int top = (int) ((length / 4) * Math.sqrt(3));
    int bottom = (int) ((length / 2) * Math.sqrt(3));
    int newLength = length / 2;
    fill(FILL_COLOR);

    {
      triangle(
        x, y,
        x - (length / 4), y + top,
        x + (length / 4), y + top
        );
      drawFunnyTriangle(x, y, newLength);
      triangle(
        x - (length / 4), y + top,
        x - (length / 2), y + bottom,
        x, y + bottom
        );
      drawFunnyTriangle(x - (length / 4), y + top, newLength);
      triangle(
        x + (length / 4), y + top,
        x + (length / 2), y + bottom,
        x, y + bottom
        );
      drawFunnyTriangle(x + (length / 4), y + top, newLength);
    }

    fill(BG_COLOR);
    triangle(
      x - (length / 4), y + top,
      x + (length / 4), y + top,
      x, y + bottom
      );
  }
}
