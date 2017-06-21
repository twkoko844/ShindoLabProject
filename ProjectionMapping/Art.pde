public abstract class Art {
  
  // field variable
  // art no
  private int artNo;
  
  // constructor
  public int getArtNo() {
    return artNo;
  }
  
  // method definition
  public void setArtNo(int artNo) {
    this.artNo = artNo;
  }
  
  public abstract PImage generateArtImage();
  
  public abstract void reset();
}

