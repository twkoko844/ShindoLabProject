public class FineArt extends Art {

  // field variable
  private int lineSize;
  private int maxLines;
  private float loops;
  private float addedValue;

  // constructor
  public FineArt() {
    setArtNo(2);
    lineSize = 10;
    maxLines = width / (lineSize * 2) ;
    loops = 0;
    addedValue = 5;
  }

  // method definition
  @Override
  public PImage generateArtImage() {
    int centerPosX = width / 2;
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(128);
    pg.strokeWeight(lineSize);
    pg.pushMatrix();

    for (int i = 0; i < maxLines; i++ ) {
      pg.strokeCap(SQUARE);
      pg.stroke(255, 32, 64);
      pg.line(centerPosX - loops, height - i * (lineSize * 2) + loops * 2, 
        width, height - i * (lineSize * 2) );
      pg.stroke(0, 255, 120);
      pg.line(centerPosX + loops, height + lineSize  - i * (lineSize * 2) + loops * 2, 
        0, height + lineSize - i * (lineSize * 2));
    }

    pg.popMatrix();
    pg.endDraw();

    loops += addedValue;
    if (loops > 300) {
      addedValue = -2;
    } else if (loops < -300 ) {
      addedValue = 2;
    }

    return pg.get();
  }

  @Override
  public void reset() {
    loops = 0;
    addedValue = 5;
  }

}
