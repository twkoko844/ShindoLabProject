PImage drawTglRise() {
  pg.beginDraw();
  pg.background(0, 0, 0, 0);
  pg.blendMode(ADD);
  ary_tgl.add(new TglRise());
  for (int i = 0; i < ary_tgl.size (); i++) {
    ary_tgl.get(i).update();
  }
  pg.endDraw();
  pg.blendMode(BLEND);
  return pg.get(0, 0, pg.width, pg.height);
}

class TglRise {
  int xpos, ypos;
  int d, alpha;
  int maxd;
  //int timecnt;
  int wise;
  color col;
  TglRise() {
    xpos = (int)random(300, width-300);
    ypos = (int)random(height-50, height-100);
    d = 30;
    alpha = 150;
    maxd = 150;
    //timer = 0;
    wise = (int)random(4);
    col = color(random(255), random(255), random(255));
  }
  void update() {
    float ra = radians(map(ypos, 0, 768, 0, 180));
    int yspeed = abs((int)(50 * cos(ra)));
    if (yspeed < 5) yspeed = 5;
    ypos = ypos - yspeed;
    d += 3;
    if (d > this.maxd) {
      alpha -= 10;
    }
    //timer = 0;
    if (ypos < 0 || ypos > height) {
      ary_tgl.remove(this);
    }
    pg.noStroke();
    pg.fill(col, alpha);
    //pg.noFill();
    //pg.strokeWeight(10);
    //pg.stroke(255, 255, 255, alpha);
    float b = this.d * sqrt(3) / 4.0;
    float c = this.d / 4.0;
    float d = c * tan(radians(30));

    float x1 = 0;
    float y1 = -(b + d);

    float r = radians(120);
    float x2 = x1*cos(r) - y1*sin(r);
    float y2 = x1*sin(r) + y1*cos(r);

    float x3 = x1*cos(r*2) - y1*sin(r*2);
    float y3 = x1*sin(r*2) + y1*cos(r*2);

    pg.pushMatrix();
    pg.translate(this.xpos, this.ypos);
    if (wise == 0) {
      pg.rotate(radians(-d));
    } else if (wise == 1) {
      pg.rotate(radians(d));
    } else if (wise == 2) {
      pg.rotate(radians(180-d));
    } else {
      pg.rotate(radians(180+d));
    }
    //pg.rotate(radians(d));
    pg.triangle(x1, y1, x2, y2, x3, y3);
    pg.popMatrix();
  }
}

