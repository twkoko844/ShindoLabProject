public class Controller {

  // field variable
  public static final int WAITING_MODE = 999;
  public static final int SETUP_MODE   = 0;
  public static final int MASK_MODE    = 1;
  public static final int ART_MODE     = 2;
  public static final int CAMERA_MODE  = 12;
  public static final int PLAY_MODE    = 100;
  private Camera cam;
  private ArtFactory artFactory;
  private Art art;
  private int currentMode;
  private int currentSection;
  private int[] sectionTable = {  // {3, 0, 2}
    ArtFactory.TGL_RISE, ArtFactory.LOGO_LOTATE, ArtFactory.EARTH_VECTOR };
  private int[] sectionTime = { 0, 3000, 6000 };
  private int playEpochTime;

  // constructor
  public Controller() {
    this(0);
  }

  public Controller(int mode) {
    cam = new Camera();
    artFactory = new ArtFactory();
    art = artFactory.getArt(ArtFactory.LOGO_LOTATE);
    currentMode = mode;
    currentSection = -1;
    playEpochTime = 0;
  }

  // method definition
  public void run() {
    switch (currentMode) {
    case WAITING_MODE:
      return;
    case SETUP_MODE:
      displaySetup();
      // insert here
      break;
    case MASK_MODE:
      displayMaskedImage();
      // insert here
      break;
    case ART_MODE:
      diplayArt();
      break;
    case CAMERA_MODE:
      displayCameraImage();
      break;
    case PLAY_MODE:
      play();
      break;
    }
  }

  public int getCurrentArtNo() {
    return art.getArtNo();
  }
  public int getCurrentMode() {
    return currentMode;
  }
  public int getCurrentSection() {
    return currentSection;
  }
  public int getPlayEpochTime() {
    return playEpochTime;
  }

  public void setArt(int artNo) {
    if (art == artFactory.getArt(artNo)) {
    }
    art = artFactory.getArt(artNo);
  }

  public void setMode(int mode) {
    this.currentMode = mode;
    switch (currentMode) {
    case SETUP_MODE:
    case MASK_MODE:
    case CAMERA_MODE:
      currentSection = -1;
    case WAITING_MODE:
      playEpochTime = 0;
      break;
    case ART_MODE:
    case PLAY_MODE:
      currentSection = 0;
      playEpochTime = millis();
      break;
    }
  }

  public void displaySetup() {
    //PImage screenImage = cam.getMaskImage();
    //image(screenImage, 0, 0, width, height);
    showCalibrationLine();
  }

  public void displayMaskedImage() {
    PImage screenImage = art.generateArtImage();
    PImage mask = cam.getMaskImage();
    screenImage.mask(mask);
     image(screenImage, 0, 0, width, height);
    //image(cam.getMaskImage(), 0, 0);
  }

  public void displayCameraImage() {
    PImage screenImage = cam.getCameraImage();
    image(screenImage, 0, 0, width, height);
  }

  public void diplayArt() {
    PImage screenImage = art.generateArtImage();
    image(screenImage, 0, 0, width, height);
  }

  public void play() {
    lotateSection();
    this.diplayArt();
  }

  private void lotateSection() {
    int currentTime = millis() - playEpochTime;

    if (currentTime <= sectionTime[1] && art.getArtNo() != sectionTable[currentSection]) {
      // Section 1 Show TglRise
      println("Section 1 TGL RISE" + "  currentTime : " + currentTime);
      currentSection = 0;
      art = artFactory.getArt(sectionTable[currentSection]);
    } else if (sectionTime[1] < currentTime && currentTime <= sectionTime[2] && art.getArtNo() != sectionTable[1]) {
      // Section 2 Show Ad
      println("Section 2 LOGO LOTATE" + "  currentTime : " + currentTime);
      currentSection = 1;
      art = artFactory.getArt(sectionTable[currentSection]);
    } else if (sectionTime[2] < currentTime && art.getArtNo() != sectionTable[2]) {
      // Section 3 Show Earth
      println("Section 3 EARTH VECTOR" + "  currentTime : " + currentTime);
      currentSection = 2;
      art = artFactory.getArt(sectionTable[currentSection]);
    }
  }

  private void showCalibrationLine() {
    stroke(255, 0, 0, 100);
    line(width / 2, 0, width / 2, height);
    line(0, height / 2, width, height / 2);
  }
}

