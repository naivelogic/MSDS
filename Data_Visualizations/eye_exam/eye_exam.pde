// Inspiration: http://learningprocessing.com/examples/chp15/example-15-09-FlashLight
// Example 15-9: Adjusting image brightness based on pixel location (Flashlight effect)

PImage iris;

void setup(){
  size(500,287);
  iris = loadImage("eye_exam_01.jpg");
}

void draw(){
  loadPixels();
  iris.loadPixels();

  
  for(int x = 0; x < width-1; x++){
    for(int y = 0; y < height; y++){
      
      // Get location of the 1D pixel
      int loc = x+y*width;

      //flashlight effect based on RGB 
      float r = red(iris.pixels[loc]);
      float b = blue(iris.pixels[loc]);
      float g = green(iris.pixels[loc]);

      // get mouse distance
      float distance = dist(mouseX, mouseY, x,y);
      int flashlight_size = 50;

      // inverse the color to detect concerns with iris
      float inverse_dist = 1-distance/flashlight_size;
      // http://atduskgreg.github.io/Processing-Shader-Examples/
      r = ((1-inverse_dist)*(255/2))+((255-r)*inverse_dist) ;
      g = ((1-inverse_dist)*(255/2))+((255-g)*inverse_dist) ;
      b = ((1-inverse_dist)*(255/2))+((255-b)*inverse_dist) ;

    }
  }
  updatePixels();
}