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
    if (epochtime == 0) {
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
      float currenttime = millis() - earth.epochtime;
      pg.shapeMode(CENTER);
      float x;
      if (currenttime > 5000) {
        x = 5000;
      } else {
        x = currenttime;
      }
      float sc = map(x, 0, 5000, 12, 2);
      //float sc = 2;
      //println(sc);
      pg.shape(shape, width/2, height/2, shape.width*sc, shape.height*sc);

      if (currenttime >= 5000) {
        float y = currenttime - 5000;

        float alpha = map(y, 0, 5000, 0, 255);
        pg.tint(255, alpha);
        //println(alpha);
        pg.imageMode(CENTER);
        pg.image(img, width/2, height/2);
        pg.imageMode(CORNER);
      }
    }
    pg.popMatrix();
    pg.endDraw();
  }

  PImage get() {
    return pg.get();
  }
}

