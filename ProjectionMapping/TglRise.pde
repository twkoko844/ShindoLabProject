public class TglRise extends Art {

  // field variable
  private ArrayList<Triangle> tglAry;

  // constructor
  public TglRise() {
    setArtNo(3);
    tglAry = new ArrayList<Triangle>();
  }

  // method definition
  @Override
  public PImage generateArtImage() {
    tglAry.add( new Triangle() );

    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(0, 0, 0, 0);
    pg.blendMode(ADD);
    pg.noStroke();
    for (int i = 0; i < tglAry.size (); i++) {
      Triangle tgl = tglAry.get(i);
      // update
      float rad = radians(map(tgl.getPosY(), 0, 768, 0, 180));
      int yspeed = abs((int)(50 * cos(rad)));
      if (yspeed < 5) yspeed = 5;
      tgl.updatePosY(-yspeed);
      if (0 > tgl.getPosY() || tgl.getPosY() > height) {
        tglAry.remove(tgl);
        continue;
      }
      tgl.updateCurrentSize(3);
      if (tgl.getCurrentSize() > tgl.getMaxSize()) {
        tgl.updateAlpha(-15);
      }

      // calc position
      float[] pos = calcPosition(tgl.getCurrentSize());

      // show
      pg.pushMatrix();
      pg.fill(tgl.getColor(), tgl.getAlpha());
      pg.translate(tgl.getPosX(), tgl.getPosY());
      int wise = tgl.getWise();
      int cs = tgl.getCurrentSize();
      if (wise == 0) {
        pg.rotate(radians(-cs));
      } else if (wise == 1) {
        pg.rotate(radians(cs));
      } else if (wise == 2) {
        pg.rotate(radians(180 - cs));
      } else {
        pg.rotate(radians(180 + cs));
      }
      pg.triangle(pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);
      pg.popMatrix();
    }
    pg.endDraw();
    pg.blendMode(BLEND);

    return pg.get(0, 0, pg.width, pg.height);
  }

  @Override
  public void reset() {
    tglAry.clear();
  }

  private float[] calcPosition(int currentSize) {
    // calc position
    float b = currentSize * sqrt(3) / 4.0;
    float c = currentSize / 4.0;
    float d = c * tan(radians(30));

    float x1 = 0;
    float y1 = -(b + d);

    float r = radians(120);
    float x2 = x1 * cos(r) - y1 * sin(r);
    float y2 = x1 * sin(r) + y1 * cos(r);

    float x3 = x1 * cos(r * 2) - y1 * sin(r * 2);
    float y3 = x1 * sin(r * 2) + y1 * cos(r * 2);
    float[] pos = { x1, y1, x2, y2, x3, y3 };
    return pos;
  }
}

// Triangle Class
public class Triangle {
  private int posX, posY;
  private int currentSize;
  private int alpha;
  private int maxSize;
  private int wise;
  private color col;

  public Triangle() {
    posX = (int) random(300, width - 300);
    posY = (int) random(height - 50, height - 100);
    currentSize = 30;
    alpha = 150;
    maxSize = 150;
    wise = (int) random(4);
    col = color(random(255), random(255), random(255));
  }

  public void updatePosX(int x) {
    this.posX += x;
  }
  public void updatePosY(int y) {
    this.posY += y;
  }
  public void updateCurrentSize(int n) {
    this.currentSize += n;
  }
  public void updateAlpha(int n) {
    this.alpha += n;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public int getCurrentSize() {
    return currentSize;
  }

  public int getAlpha() {
    return alpha;
  }

  public int getMaxSize() {
    return maxSize;
  }

  public int getWise() {
    return wise;
  }

  public color getColor() {
    return col;
  }

}
