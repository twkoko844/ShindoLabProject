public class ArtFactory {
  
  // field variable
  public static final int LOGO_LOTATE = 0;
  public static final int EARTH_VECTOR = 1;
  public static final int FINE_ART = 2;
  public static final int TGL_RISE = 3;
  Art logoLotate;
  Art earthVector;
  Art fineArt;
  Art tglRise;
  
  // constructor
  public ArtFactory() {
    String[] logoFilesName = {
      "apple.jpg", "IBM.jpg", "seven.jpg", "toyota.jpg", "uniqlo.gif" };
    logoLotate = new LogoLotate("nikkei-vertical.jpg", logoFilesName);
    earthVector = new EarthVector("earth.svg", "earth_color.png");
    fineArt = new FineArt();
    tglRise = new TglRise();
  }
  
  // method definition
  public Art getArt(int artNo) {
    Art art = null;
    switch (artNo) {
    case LOGO_LOTATE :
      art = logoLotate;
      break;
    case EARTH_VECTOR :
      art = earthVector;
      break;
    case FINE_ART :
      art = fineArt;
      break;
    case TGL_RISE :
      art = tglRise;
      break;
    }
    art.reset();
    return art;
  }
  
}
