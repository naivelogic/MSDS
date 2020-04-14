// https://discourse.processing.org/t/rotating-in-3d-help/2573/3

color[] colors = { color(200,0,0), color(0,200,0), color(0,0,200) };

void setup() {
  size(600, 400, P3D);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  lights();  
  noStroke();
  for ( int i = -3; i < 4; i++) {
    pushMatrix();
    translate(i*100, 0, 0);
    switch ((i+3)%3){
      case 0:
        rotateX(map(millis(),0,5000,0,TWO_PI));
        break;
      case 1:
        rotateY(map(millis(),0,5000,0,TWO_PI));
        break;
      case 2:
        rotateZ(map(millis(),0,5000,0,TWO_PI));
        break;
    }
    fill(colors[(i+3)%colors.length]);
    box(40);
    popMatrix();
  }
}