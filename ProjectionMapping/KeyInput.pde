void keyPressed() {
  println("input : " + key);
  if (key == 'h' ) {
    println("w as mode WAIT for waiting and screen black");
    println("m as mode MASK for Masked Art");
    println("a as mode ART for Unmasked Art");
    println("c as mode CAMERA for Camera only mode");
    println("space as start music and visual effect");
    println("e as Exit");
    return;
  }
  if (key == '0') {
    println("set art LOGO_LOTATE");
    controller.setArt(ArtFactory.LOGO_LOTATE);
    return;
  }
  if (key == '1') {
    println("set art EARTH_VECTOR");
    controller.setArt(ArtFactory.EARTH_VECTOR);
    return;
  }
  if (key == '2') {
    println("set art FINE_ART");
    controller.setArt(ArtFactory.FINE_ART);
    return;
  }
  if (key == '3') {
    println("set art TGL_RISE");
    controller.setArt(ArtFactory.TGL_RISE);
    return;
  }
  if (key == 'w') {
    println("set mode Waiting");
    controller.setMode(Controller.WAITING_MODE);
    return;
  }
  if (key == 's') {
    println("set mode Setup ");
    controller.setMode(Controller.SETUP_MODE);
    return;
  }
  if (key == 'm') {
    println("mask mode : display masked image");
    controller.setMode(Controller.MASK_MODE);
    return;
  }
  if (key == 'c') {
    println("camera mode : display camera image");
    controller.setMode(Controller.CAMERA_MODE);
    return;
  }
  if (key == 'a') {
    println("art mode Art");
    controller.setMode(Controller.ART_MODE);
    return;
  }
  if (key == ' ') {
    println("Play start");
    controller.setMode(Controller.PLAY_MODE);
    return;
  }
  if (key == 'e') {
    println("exit...");
    exit();
  }
  if (key == ',') {
    transDistance--;
    println("transdistance : " + transDistance);
    return;
  }
  if (key == '.') {
    transDistance++;
    println("transdistance : " + transDistance);
    return;
  }
}
