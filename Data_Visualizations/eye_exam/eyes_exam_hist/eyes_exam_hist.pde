// http://learningprocessing.com/examples/chp15/example-15-03-ImageArray1
// Example 15-3: Swapping images

int maxImages = 3; // Total # of images
int imageIndex = 0; // Initial image to be displayed is the first

// Declaring an array of images.
PImage[] images = new PImage[maxImages]; 

void setup() {
  size(500, 500);

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
    int[] hist = new int[256];

    // Calculate the histogram
    for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
        int bright = int(brightness(get(i, j)));
        hist[bright]++; 
      }
    }

    // Find the largest value in the histogram
    int histMax = max(hist);

    stroke(255);
    // Draw half of the histogram (skip every second value)
    for (int i = 0; i < img.width; i += 2) {
      int which = int(map(i, 0, img.width, 0, 255));
      // move hist
      int y = int(map(hist[which], 0, histMax, img.height, 0));
      line(i, img.height, i, y);
    }

  text("Visual # 3 - Midterm - Vizualizing Distribution of  Pixel Brightness", 30 , 440);
  text("Histogram of Different kinds of color by brightness measurement in the image", 30 , 450);
  text("By using the Images and Pixes shows converted as...", 30, 460);
  text("a numeric value and displayed as a histogram to indicate brighter pixels", 30, 470);
  text("PRESS MOUSE TO CHANGE PICTURES", 40, 400);
}

void mousePressed() {
  // A new image is picked randomly when the mouse is clicked
  // Note the index to the array must be an integer!
  imageIndex = int(random(images.length));
}