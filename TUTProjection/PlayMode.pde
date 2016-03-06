PImage playMode() {
  int currentTime;
  currentTime = millis() - playEpocTime;
  if (currentTime <= sectionTime[1]) {
    // Section 1 Show TglRise
    generatedArt = drawTglRise();
    generatedArt.mask(mask);
  }
  if (currentTime > sectionTime[1] && currentTime <= sectionTime[2]) {
    // Section 2 Show Ad
    generatedArt = GenerateArtImage();
    generatedArt.mask(mask);
  }
  if (currentTime > sectionTime[2] ) {
    // Section 3 Show Earth
    // Call only once when it started.
    earth.setEpochTime();
    earth.update();
    generatedArt = earth.get();
  }
  return generatedArt;
}

