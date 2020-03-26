class background_image {
  PImage bg;

  background_image(final PImage img) {
    bg = img;
    fitToCanvas();
  }

  background_image fitToCanvas() {
    bg.resize(width, height);
    return this;
  }

  background_image show() {
    background(bg);
    return this;
  }
}