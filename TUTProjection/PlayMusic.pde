void playMusicSetup() {
  //Music 
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");
}
void playMusicPlay() {
  playEpocTime = millis();
  player.play();
  player.rewind();
}
void playMusicStop() {
  player.pause();
  player.rewind();
}

