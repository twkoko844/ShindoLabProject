import processing.video.*;
import gab.opencv.*;

Controller controller;
int transDistance = 0;

void setup() {
  // Mac display size 1440x900
  // Camera size 1280x720
  int x = 1280;
  int y = 720;
//  size(displayWidth, displayHeight);
  size(x, y);
  controller = new Controller();
}

void draw() {

  background(0); // Anyway, always black
  imageMode(CORNER);  

  controller.run();
}

// get new methods
// use instantiation
Capture getNewCapture(String str) {
  return new Capture(this, str);
}

OpenCV getNewOpenCV(int x, int y) {
  return new OpenCV(this, x, y);
}

