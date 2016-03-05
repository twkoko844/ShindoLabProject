PImage GenerateFineArtImage() {
  pg.beginDraw();
  pg.background(128);
  pg.strokeWeight(fa_linesize);

  pg.pushMatrix();
  for (int i = 0; i < fa_maxlines; i++ ) {
    pg.strokeCap(SQUARE);
    pg.stroke(255, 32, 64);
    pg.line(centerX - fa_loops, height - i*(fa_linesize*2)+fa_loops*2, width, height - i*(fa_linesize*2));
    pg.stroke(0, 255, 120);
    pg.line(centerX + fa_loops, height + fa_linesize  - i*(fa_linesize*2) +fa_loops*2, 
      0, height + fa_linesize - i*(fa_linesize*2));
  }
  pg.popMatrix();
  pg.endDraw();

  fa_loops+= fa_addedval;
  if (fa_loops > 300) {
    fa_addedval = -2;
  } else if (fa_loops < -300 ) {
    fa_addedval=2;
  }
  return pg.get();
}

void GenerateFineArtImageReset() {
  fa_maxlines = width / (fa_linesize*2) ;
  fa_loops=-100;
  fa_addedval=5;
}
