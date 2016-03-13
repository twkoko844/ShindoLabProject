void keyPressed() {
  if (key == 'h' ) {
    println("0 as mode zero for Setup mode");
    println("1 as mode one for Masked Art");
    println("2 as mode two for Unmasked Art");
    println("c as mode Camera for Camera only mode");
    println("w as mode Wait for waiting and screen black");
    println("space as start music and visual effect");
    return;
  }
  if (key == '0') {
    println("mode zero, setupmode");
    runningMode = 0;
    return;
  }
  if (key == '1') {
    println("mode one, Masked Art");
    runningMode = 1;
    resetArtEpochTime();
    return;
  }
  if (key == '2') {
    println("mode two, Unmasked Art");
    runningMode = 2;
    resetArtEpochTime();
    return;
  }
  if (key == 'w') {
    println("mode wait, waiting mode");
    runningMode = 999;
    playMusicStop();
    return;
  }
  if (key == 'c') {
    println("mode Camera, Camera only mode");
    runningMode = 12;
    return;
  }
  if (key == ' ') {
    println("play : start music and visual effect");
    runningMode = 100;
    GenerateFineArtImageReset();
    playMusicPlay();
    return;
  }
}
