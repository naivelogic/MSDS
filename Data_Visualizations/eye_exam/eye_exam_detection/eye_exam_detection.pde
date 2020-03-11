// http://learningprocessing.com/examples/chp15/example-15-03-ImageArray1
// Example 15-3: Swapping images
PImage img;
int maxImages = 3; // Total # of images
int imageIndex = 0; // Initial image to be displayed is the first

// Declaring an array of images.
PImage[] images = new PImage[maxImages]; 

void setup() {
  size(500, 300);

  // Loading the images into the array
  // Don't forget to put the JPG files in the data folder!
  for (int i = 0; i < images.length; i ++ ) {
    images[i] = loadImage( "eye_exam_0" + i + ".jpg" );
  }
}

void draw() {

    // Displaying one image
    image(images[imageIndex], 0, 0);
    PImage img = images[imageIndex];
    loadPixels();
    img.loadPixels();

    for(int x = 0; x < img.width-1; x++){
        for(int y = 0; y < img.height; y++){
        
            // Get location of the 1D pixel
            int loc = x+y*width;

            //flashlight effect based on RGB 
            float r = red(img.pixels[loc]);
            float b = blue(img.pixels[loc]);
            float g = green(img.pixels[loc]);

            // get mouse distance
            float distance = dist(mouseX, mouseY, x,y);
            int flashlight_size = 50;


            // inverse the color to detect concerns with iris
            float inverse_dist = 1-distance/flashlight_size;
            // http://atduskgreg.github.io/Processing-Shader-Examples/
            r = ((1-inverse_dist)*(255/2))+((255-r)*inverse_dist) ;
            g = ((1-inverse_dist)*(255/2))+((255-g)*inverse_dist) ;
            b = ((1-inverse_dist)*(255/2))+((255-b)*inverse_dist) ;

            // Adjust Mouse Brightness
            float adjustBrightness = map(mouseX, 0, width, 0, 8); 
            r *= adjustBrightness;
            g *= adjustBrightness;
            b *= adjustBrightness;

            color c = color(r, g, b);
            pixels[loc] = c;
            // looking to map mouse location and current flashlight pixels for analysis for cancer
            // however takes a lot of Processing
            // looking to save
            //println(hue(c));


        }
    }
  updatePixels();
  
}

void mousePressed() {
  // A new image is picked randomly when the mouse is clicked
  // Note the index to the array must be an integer!
  imageIndex = int(random(images.length));
}