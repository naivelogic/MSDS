// https://github.com/koraloral/COD208/blob/854cc6765c6ed9da956cf2a1643632438b8fea6a/Lec_7_1/sketch_170314c.pde

// https://github.com/koraloral/COD208/blob/854cc6765c6ed9da956cf2a1643632438b8fea6a/Lec_7_1/sketch_170314c.pde
float angle;

Table table;
float r = 200;

private Plot[] earning_plots;
PImage earth;
//PShape globe;

void setup() {
  size(600, 600, P3D);
  frameRate(20);

  //earth = loadImage("earth.jpg"); 
  table = loadTable("data/kobe.csv", "header");


  noStroke();
  //globe = createShape(SPHERE, r);
  //globe.setTexture(earth);
}

void draw() {
  background(0);
  float cameraY = height/2.0;
  float fov = mouseX/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  if (mousePressed) {
    aspect = aspect / 2.0;
  }
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);

  // apply lights 
  lights();

  //translate(width/2+30, height/2, 0);
  //rotateX(-PI/6);
  //rotateY(PI/3 + mouseY/float(height) * PI);



  // move the center point
  translate(width/2, height/2, 0);
  rotateY(angle);
  angle += 0.01;

  // move the center point
  //translate(width/2, height/2, 0);

  //rotationSpeed = Leverage Ratio (about 0.002)
  //float rotationSpeed = leverage_ratio/80;
  //float rotationSpeed = 0.002/80;

  //rotateY(frameCount*rotationSpeed);
  //rotateZ(frameCount*rotationSpeed);



  for (TableRow row : table.rows()) {
    float lat = row.getFloat("loc_x");
    float lon = row.getFloat("loc_y");
    float mag = row.getFloat("seconds_remaining");
    float shot_made = row.getFloat("shot_made_flag");
    float shot_zone = 10* row.getFloat("shot_zone");
    float theta = radians(lat) + PI/2;
    //float theta = radians(lat);
    float phi = radians(lon) + PI;
    
    float x = shot_zone * sin(theta) * cos(phi);
    //float y = - r * sin(theta);
    //float z = - r * cos(theta) * sin (phi);
    float y = - shot_zone * sin(theta) * sin(phi);
    float z =  shot_zone * cos(theta);
    PVector pos = new PVector(x, y, z);

    // https://discourse.processing.org/t/3d-camera-view-top-view/12019/2
    float h = pow(10, mag);
    float maxh = pow(10, 7);
    h = map(h, 0, maxh, 10, 100);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);

    pushMatrix();
    translate(x, y, z);

    rotate(angleb, raxis.x, raxis.y, raxis.z);
    
    //noStroke();
    if (shot_made == 0 ){
        fill(255, 0, 0);
        //box(h, 5, 5);
    }
    if (shot_made == 1){
        fill(255, 255, 255);
        //box(h, 5, 5);
    }
    //fill(255*shot_made, 255*shot_made, 255*shot_made);
    sphere(2);
    popMatrix();

  }
}

private class Plot {
  final float x, y, z;
  Plot(float radius) {
    // randomly calculate position on sphere
    float unitZ = random(-1, 1);
    float radianT = radians(random(360));
    x = radius * sqrt(1 - unitZ * unitZ) * cos(radianT);
    y = radius * sqrt(1 - unitZ * unitZ) * sin(radianT);
    z = radius * unitZ;
  }
}
