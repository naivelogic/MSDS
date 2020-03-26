// https://gist.github.com/atduskgreg/666e46c8408e2a33b09a
static final String FILE = "background.jpg";
background_image bgImg;
window2 win;

colorh eyeees;

public void settings() {
  size(500, 700);
  
}



void setup() { 
    
    stroke(0);
  win = new window2();
  bgImg = new background_image(loadImage(FILE));
  eyeees = new colorh();
}

void draw() {
    bgImg.show();
    //colorImg.hist_me();
    eyeees.show();
  
}


 
