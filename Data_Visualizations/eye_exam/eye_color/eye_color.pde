// http://learningprocessing.com/examples/chp15/example-15-03-ImageArray1
// Example 15-3: Swapping images

int maxImages = 3; // Total # of images
int imageIndex = 0; // Initial image to be displayed is the first

// Declaring an array of images.
PImage[] images = new PImage[maxImages]; 

void setup() {
  size(500, 700);

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
    //image(img, 0, 0);

    colorMode(HSB);
    int countBlack = 0;
    // 300 // 500
    for ( int x =0; x< img.height; x++)
        for ( int y =0; y< img.width; y++) {
            color px = img.get(x, y);
            int r = int(red(px));
            int g = int(green(px));
            int b = int(blue(px));

            if ( r < 100 && g >= 100 && b < 100 ) {
                circle(x, y, 3);
                //println(x, y, r, g, b);
            }
            
            float h = hue(color(x,255, 255));
            float diff = h-x;
            
            pushMatrix();
            translate(0, 300);
            fill(abs(diff) < 0.01 ? #008800 : #880000 );
            rect(x*2, diff*200, 2, 30);
            popMatrix();
            
        }

    textSize(10);
    text("PRESS MOUSE TO CHANGE PICTURES", 40, 380);

    textSize(15);
    fill(204, 102, 0);
    text("Visuals# 1&2 - Midterm Pixel Analysis for specific Color Detection. ", 10 , 400);

    textSize(12);
    fill(50);
    String s = "Visual #1 - Circle Indicators on Iris (color coded - see legend) The rectanges calculate the convert RGB pixels in the image (total Images - updating challenges for pixels), and averages the HUE and sums over all pixels. This provides a this provides a 'Density like Heat Map' for colors of interest on iris.";
    text(s, 10, 405, 480, 80);  // Text wraps within text box

    String s2 = "Visual #2 - 'Density like Heat Map' - Rectagles are plotted indicating the HUE comparision colors of interest on iris. Bug: Currently this is a static comparision, working on making this a dynamic update with the pixels";
    text(s2, 10, 490, 480, 80);  // Text wraps within text box

    
    text("Color Legend:", 10, 580);
    String s3 = "Color Description: Diff colors indicate levels of concern. Hypothesis, using Hue differential distance function to determine extrememly important cases for tracking good colors (Green) and significantly differnet via Hue comparision color (Red). Special Color Detection: Red & 100 + Green >= 100 & Blue < 100";
    text(s3, 10, 590, 480, 100);  // Text wraps within text box
  

}

void mousePressed() {
  // A new image is picked randomly when the mouse is clicked
  // Note the index to the array must be an integer!
  imageIndex = int(random(images.length));
}