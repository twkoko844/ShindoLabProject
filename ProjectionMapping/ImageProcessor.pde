public class ImageProcessor {

  // method definition
  public PImage artMasking(PImage artImage, PImage maskImage) {
    artImage.mask(maskImage);
    return artImage;
  }
  public PImage imageScaling(PImage image, float scale) {
    image.resize(int(image.width * scale), int(image.height * scale));
    return image;
  }

  public PImage _imageScaling(PImage image, float scale) {
    imageMode(CENTER);
    image(image, width / 2, height / 2, image.width * scale, image.height * scale);
    imageMode(CORNER);
    PImage imgResult = get(0, 0, width, height);
    background(0);
    return imgResult;
  }
}

