PImage GenerateArtImage() {
  return logoLotate();
}

void generateArtInit() {
  int xpos = 0;
  float r = 0.7;
  logoImage[0]=new LogoImage("toyota.jpg", xpos, height/2, r, 1000);
  logoImage[1]=new LogoImage("seven.jpg", xpos, height/2, r, 3000);
  logoImage[2]=new LogoImage("IBM.jpg", xpos, height/2, r, 5000);
  logoImage[3]=new LogoImage("uniqlo.gif", xpos, height/2, r, 7000);
  logoImage[4]=new LogoImage("apple.jpg", xpos, height/2, r, 9000);
  maxImages=5;
  bodyImage = loadImage("nikkei-vertical.jpg");
  EpochTime=millis();
}
void resetArtEpochTime() {
  EpochTime=millis();
}

PImage logoLotate() {
  pg.beginDraw();
  pg.background(0);
  pg.pushMatrix();
  pg.imageMode(CENTER);
  float r = 1;
  pg.image(bodyImage, width/2 + transdistance, height/2, bodyImage.width * r, bodyImage.height * r);
  pg.popMatrix();
  logoImage[logotable].show();
  pg.endDraw();
  logoImage[logotable].update();
  return pg.get();
}

class LogoImage {
  PImage myimage;
  float posX, posY, startX, startY, vecx, vecy;
  float rate;
  int startTime;
  int myEpochTime;
  LogoImage(String filename, int x, int y, float myrate, int starttime) {
    myEpochTime = EpochTime;
    myimage = loadImage(filename);
    posX=startX=0;
    posY=startY=height/2;
    vecx = 5;
    vecy = 0;
    startTime=0;
    rate = myrate;
  }
  void show() {
    if (millis() - myEpochTime > startTime) {
      pg.pushMatrix();
      pg.imageMode(CENTER);
      pg.image(myimage, posX + transdistance, posY, myimage.width*rate, myimage.height*rate);
      pg.popMatrix();
    }
  }
  void update() {    
    float ra = radians(map(posX, 0, width, 0, 180));
    vecx = abs((int)(110 * cos(ra)));
    if (vecx < 10) vecx = 10;
    posX += vecx;
    posY += vecy;
    if (posX < 0 || posX > width || posY < 0 || posY > height) {
      reset();
    }
  }
  void reset() {
    posX = startX;
    posY = startY;
    myEpochTime = millis();
    startTime = 0;
    logotable = (logotable+1) % 5;
  }
}

