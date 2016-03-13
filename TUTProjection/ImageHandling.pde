PImage imageProcessing() {
  
  cv.gray();
  cv.contrast(contrast);
  cv.threshold(threshold);
  //cv.invert();
  cv.dilate();
  cv.erode();
  cv.blur(blurSize);
  mask = cv.getSnapshot();
  return mask;
}
PImage artMasking(PImage artimage, PImage mask) {
  return null;
}
PImage imageScaling(PImage src, float scale) {
  PImage result;
  imageMode(CENTER);
  image(src, width/2, height/2, src.width*scale, src.height*scale);
  imageMode(CORNER);
  result = get(0, 0, width, height);
  background(0);
  return result;
}
