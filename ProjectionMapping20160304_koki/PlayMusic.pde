void playMusicSetup() {
  //Music 
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");
}
void playMusicPlay() {
  player.rewind();
  player.play();
}

