import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import controlP5.*;
import ddf.minim.*;

Capture cam;
PGraphics pg; // Graphic Campus
PImage pimage;
PImage cameraImage; 
OpenCV cv;

/// Images
PImage mask;
PImage screenImage;
PImage generatedArt;

// Play Mode setting.
int playSection = 0;
int playEpocTime;
int[] sectionTime = {0, 20000, 32000};

//
// Set Default
//
float scale = 1; // camera zoom rate
float contrast = 1.35;
int brightness = 0;
int threshold = 150;
int blurSize = 4;
float transdistance = 0;
int runningMode = 12;

PMSetting pmsetting;

// Center Posistion of Performer (HUMAN)
int centerX, centerY; 

ControllPanel controllpanel;

// Generate Art Image
LogoImage[] logoImage = new LogoImage[5];
int EpochTime;
int maxImages;
PImage bodyImage;
float minRate = 0.3;
int logotable = 0;

// Generate Fine Art Image
int fa_maxlines;
float fa_loops;
int fa_linesize = 10;
float fa_addedval;

// Music 
Minim minim;  
AudioPlayer player;  

// EarthVectorImage class
EarthVector earth;

//tglrise
ArrayList<TglRise> ary_tgl;

void setup() {
  int x = 1280;
  int y = 720;
  size(displayWidth, displayHeight);
  //frameRate(30);

  // Load Logo Image
  generateArtInit();
  pmsetting = new PMSetting(); // Load Paramaters from Default Setting File
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ":" + cameras[i]);
    }
    cam = new Capture(this, cameras[0]); //640x480 17th camera
    cam.width = x;
    cam.height = y;
    cam.start();
  }
  //print("cam.width:");
  //println(cam.width);
  pg = createGraphics(width, height);
  //screenImage = createImage(width, height, RGB);
  //cameraImage = createImage(cam.width, cam.height, RGB);
  cv = new OpenCV(this, cam.width, cam.height);
  controllpanel = new ControllPanel(new ControlP5(this));
  centerX = width/2;
  centerY = height/2;

  // Fine Art Paramater
  GenerateFineArtImageReset();
  //
  playMusicSetup();
  // create EarthVector object
  earth = new EarthVector("earth.svg", "earth_color.png");
  // triangle riser
  ary_tgl = new ArrayList<TglRise>();

  resetArtEpochTime();
}

void draw() {

  background(0); // Anyway, always black
  imageMode(CORNER);
  
  // Waiting mode
  if (runningMode == 999) {
    //delay(20);
    return;
  } 

  if (cam.available() == true) {
    cam.read();
    cv.loadImage(cam);
  }

  // show or hide controllpanel
  if (runningMode == 0 || runningMode == 12) {
    // Setup Mode or Camera Mode
    controllpanel.update();
  } else {
    controllpanel.hide();
  }

  // run and show image
  if (runningMode == 12) {
    // Camera Only Mode
    cv.useColor(RGB);
    cameraImage = cv.getSnapshot();
    cameraImage = imageScaling(cameraImage, scale);
    image(cameraImage, 0, 0); 
    return;
  }
  if (runningMode == 0 || runningMode == 1 || runningMode == 100) {
    // Make Mask Image
    mask = imageProcessing();
    mask = imageScaling(mask, scale);
    //println(mask.width, mask.height);
  }
  if (runningMode == 0) {
    // Setup Mode
    screenImage = mask;
  }
  if (runningMode == 1) {
    // Generate Art Image
    //generatedArt = GenerateFineArtImage();
    generatedArt = drawTglRise();
    // Masked Art Check
    generatedArt.mask(mask);
    screenImage = generatedArt;
  }
  if (runningMode == 2) {
    // Art Screen Mode (unmasked Art)
    generatedArt = GenerateArtImage();
    screenImage = generatedArt;
  }
  if (runningMode == 100) {
    // Play 
    screenImage = playMode();
  }
  if (screenImage == null) {
    // unknown error.
    println("screenImage is null");
    cv.useColor(RGB);
    screenImage = cv.getSnapshot();
    screenImage = imageScaling(cameraImage, scale);
  }

  image(screenImage, 0, 0, width, height); // show image on screen
  
  if (runningMode == 0 ) {
    // show center line
    stroke(255, 0, 0, 50);
    line(width/2 + transdistance, 0, width/2 + transdistance, height);
  }
}


public void save() {
  controllpanel.update();
  pmsetting.save();
  controllpanel.hide();
}

