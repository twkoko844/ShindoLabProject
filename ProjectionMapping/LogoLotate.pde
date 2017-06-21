public class LogoLotate extends Art {

  // method definition
  private LogoImage[] logoImage;
  private int logoStartTime;
  private int logoEpochTime;
  private int logoTable;
  private PImage bodyImage; 

  // constructor
  public LogoLotate(String bodyLogoFileName, String[] filesName) {
    setArtNo(0);
    logoImage = new LogoImage[filesName.length];
    float rate = 0.7;
    for (int i = 0; i < filesName.length; i++) {
      logoImage[i] = new LogoImage(filesName[i], rate);
    }
    bodyImage = loadImage(bodyLogoFileName);
    logoEpochTime = millis();
    logoTable = 0;
  }

  // method definition
  @Override
  public PImage generateArtImage() {
    return this.generateArtImage(0);
  }

  public PImage generateArtImage(int distance) {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(0);
    pg.pushMatrix();
    float rate = 1;
    pg.imageMode(CENTER);
    pg.image(bodyImage, width / 2 + distance, height / 2, 
    bodyImage.width * rate, bodyImage.height * rate);
    pg.imageMode(CORNER);

    if (millis() - logoEpochTime > logoStartTime) {
      PImage p = logoImage[logoTable].getImage();
      float posX = logoImage[logoTable].getPosX();
      float posY = logoImage[logoTable].getPosY();
      float lrate = logoImage[logoTable].getRate();
      pg.image(p, posX + distance, posY, p.width * lrate, p.height * lrate);
    }

    pg.popMatrix();
    pg.endDraw();
    logoImage[logoTable].update();
    if (logoImage[logoTable].getPosX() < 0 || logoImage[logoTable].getPosX() > width ||
      logoImage[logoTable].getPosY() < 0 || logoImage[logoTable].getPosY() > height) {
      lotate();
    }
    return pg.get();
  }

  @Override
  public void reset() {
    for (int i = 0; i < logoImage.length; i++) {
      logoImage[i].reset();
    }
    logoStartTime = 0;
    logoEpochTime = millis();
    logoTable = 0;
  }

  private void lotate() {
    logoImage[logoTable].reset();
    logoStartTime = 0;
    logoEpochTime = millis();
    logoTable = (logoTable + 1) % logoImage.length;
  }
}

public class LogoImage {
  private PImage image;
  private float posX, posY, startX, startY, vecX, vecY;
  private float rate;

  LogoImage(String fileName, float rate) {
    image = loadImage(fileName);
    posX = startX = 0;
    posY = startY = height / 2;
    vecX = 5;
    vecY = 0;
    this.rate = rate;
  }

  public PImage getImage() {
    return image;
  }

  public float getPosX() {
    return posX;
  }

  public float getPosY() {
    return posY;
  }

  public float getRate() {
    return rate;
  }

  public void update() {
    float radians = radians(map(posX, 0, width, 0, 180));
    vecX = abs( (int) (110 * cos(radians)) );
    if (vecX < 10) vecX = 10;
    posX += vecX;
    posY += vecY;
  }

  public void reset() {
    posX = startX;
    posY = startY;
  }
}

