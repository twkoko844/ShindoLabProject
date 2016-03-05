PImage GenerateArtImage() {
  return realGenerateArtImage();
}
PImage realGenerateArtImage() {
  //PImage tmpimage=pimage;
  pg.beginDraw();
  pg.background(0);
  pg.pushMatrix();
  pg.imageMode(CENTER);
  pg.image(bodyImage, width/2 + transdistance, height/2, bodyImage.width*0.8, bodyImage.height*0.8);
  pg.popMatrix();
  for (int i=0; i < maxImages; i++) {
    logoImage[i].show();
  }
  pg.endDraw();
  for (int i=0; i < maxImages; i++) {
    logoImage[i].update();
  }

  //tmpimage.pixels = pg.pixels;
  //tmpimage.updatePixels();
  return pg.get();
}
PImage debugGenerateArtImage() {
  //PImage tmpimage=pimage;
  pg.beginDraw();
  pg.background(0);
  pg.pushMatrix();

  pg.ellipse(width/2, height/2, 300, 300);
  pg.popMatrix();
  pg.endDraw();
  /*
  tmpimage.pixels = pg.pixels;
   tmpimage.updatePixels();
   */
  return pg.get();
}

void generateArtInit() {
  int xpos = width/2 + (int)transdistance;
  logoImage[0]=new LogoImage("toyota.jpg", xpos, height/2, 0.7, 1000);
  logoImage[1]=new LogoImage("seven.jpg", xpos, height/2, 0.7, 3000);
  logoImage[2]=new LogoImage("IBM.jpg", xpos, height/2, 0.7, 5000);
  logoImage[3]=new LogoImage("uniqlo.gif", xpos, height/2, 0.7, 7000);
  logoImage[4]=new LogoImage("apple.jpg", xpos, height/2, 0.7, 9000);
  maxImages=5;
  bodyImage = loadImage("nikkei-vertical.jpg");
  EpochTime=millis();
}
void resetArtEpochTime() {
  EpochTime=millis();
}
class LogoImage {
  PImage myimage;
  float posX, posY, startX, startY, vecx, vecy;
  float rate;
  int startTime;
  int myEpochTime;
  LogoImage(String filename, int x, int y, float myrate, int starttime) {
    myEpochTime=EpochTime;
    myimage = loadImage(filename);
    posX=startX=x;
    posY=startY=y;
    vecx = (round(random(0,1))*2 -1 ) * random(5,10);
    vecy = (round(random(0,1))*2 -1 )  * random(5,10);
    startTime=starttime;
    rate=myrate;
  }
  void show() {
    if (millis() - myEpochTime > startTime) {
      pg.pushMatrix();
      pg.imageMode(CENTER);
      pg.image(myimage, posX, posY, myimage.width*rate, myimage.height*rate);
      //ellipse(posX,posY,100,100);
      pg.popMatrix();
    }
  }
  void update() {
    if (millis() - myEpochTime < startTime) {
      return;
    }
    posX += vecx;
    posY += vecy;
    if ( posX < 0 || posX > width || posY < 0 || posY > height ) {
      reset();
    }
    rate +=0.001;
    if ( rate > 1.0 ) {
      reset();
    }
  }
  void reset() {
    posX=startX;
    posY=startY;
    rate=minRate;
    myEpochTime=millis();
  }
}
