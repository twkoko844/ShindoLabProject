public class EarthVector extends Art {

  // field variable
  PShape shape;
  PImage image;
  int earthEpochTime;

  // constructor
  public EarthVector(String shapeName, String imageName) {
    setArtNo(1);
    shape = loadShape(shapeName);
    image = loadImage(imageName);
    earthEpochTime = 0;
  }

  // method definition
  @Override
  public PImage generateArtImage() {
    if (earthEpochTime == 0) {
      // start art
      earthEpochTime = millis();
    }

    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(255);
    pg.pushMatrix();
    pg.imageMode(CENTER);
    pg.shapeMode(CENTER);

    if (earthEpochTime != 0) { 
      float currentTime = millis() - earthEpochTime;
      float rate;

      if (currentTime > 5000) {
        rate = map(5000, 0, 5000, 12, 2);
      } else {
        rate = map(currentTime, 0, 5000, 12, 2);
      }

      pg.shape(shape, width / 2, height / 2, shape.width * rate, shape.height * rate);

      if (currentTime >= 5000) {
        float alpha = map( (currentTime - 5000), 0, 5000, 0, 255 );
        //        println(alpha);
        pg.tint(255, alpha);
        pg.image(image, width / 2, height / 2);
      }
    }

    pg.popMatrix();
    pg.imageMode(CORNER);
    pg.shapeMode(CORNER);
    pg.endDraw();

    return pg.get();
  }

  @Override
  public void reset() {
    earthEpochTime = millis();
  }

}
