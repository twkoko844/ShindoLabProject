public class Camera {
  
  // field variable
  Capture cam;
  OpenCV cv;
  String[] cameras;
  
  // constructor
  public Camera() {
    cameras = Capture.list();
    printCameraList();
    cam = getNewCapture(cameras[0]);
    cam.start();
    cv = getNewOpenCV(width, height);
    cv.useColor(RGB);
  }
  
  // method definition
  public PImage getCameraImage() {
    if (cam.available()) { 
      cam.read();
      cv.loadImage(cam);
    }
    return cv.getSnapshot();
  }

  public PImage getMaskImage() {
    if (cam.available()) { 
      cam.read();
      cv.loadImage(cam);
      imageProcessing();
    }
    return cv.getSnapshot();
  }

  public void printCameraList() {
    for (String c : cameras) {
      println(c);
    }
  }

  private void imageProcessing() {
    float contrast = 100;
    int threshold = 100;
    int blur = 50;
    cv.gray();
    // cv.contrast(contrast);
    cv.threshold(threshold);
    cv.invert();
    cv.dilate();
    cv.erode();
    cv.blur(blur);
  }
  
}

