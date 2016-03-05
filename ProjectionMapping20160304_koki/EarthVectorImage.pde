
class EarthVector {
  String shapename;
  String imagename;
  PShape shape;
  PImage img;
  int epochtime;

  EarthVector(String sn, String in) {
    shapename = sn;
    imagename = in;
    shape = loadShape(sn);
    img = loadImage(in);
    epochtime = 0;
  }
  void setEpochTime() {
    if ( epochtime == 0 ) {
      this.epochtime = millis();
    }
  }
  void resetEpochTime() {
    this.epochtime = millis();
  }

  void update() {
    pg.beginDraw();
    pg.background(255);
    pg.pushMatrix();
    if (earth.epochtime != 0) { 
      int x = millis() - earth.epochtime;
      if (x > 5000) x = 5000;
      pg.shapeMode(CENTER);
      float sc = map(x, 0, 5000, 12, 2);
      //float sc = 2;
      //println(sc);
      pg.shape(earth.shape, width/2, height/2, earth.shape.width*sc, earth.shape.height*sc);

      if (x >= 5000) {
        int y = millis() - earth.epochtime - 5000;
        float alpha = map(y, 5000, 10000, 120, 255);
        pg.tint(255, alpha);
        //println(alpha);
        pg.imageMode(CENTER);

        pg.image(this.img, width/2, height/2);
      }
    }
    pg.popMatrix();
    pg.endDraw();
  }

  PImage get() {
    return pg.get();
  }
}

