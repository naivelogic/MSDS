//float counter; 
int i = 0;
//int end = 1;
float rotate_spinner = 2*TWO_PI; 
float time = 0; 
float speed = 0.03*30; 


void setup() {
  noStroke();
  smooth();
  size(447,638);
}

void draw(){
    background(color(231,220,190));
    if (i<10) {
        static_();
    } else {
        background(color(231,220,190));
        spinner(1, 1, rotate_spinner, time, 0);
        time += 0.02;
    }
    i = i+1;
    
}

void static_() {
    background(12, 34, 56);
    spinner(0, 0, 0, 0, 0);
}


void spinner(float prior, float scale, float displacement, float time, float delay){
    // Rectangle
    pushMatrix();
    translate(182,386);
    fill(205, 81, 45);
    rect(140,364, 195, 15);
    rotate((prior-2)*(displacement-3)*cos(speed-3*time/2 - (delay+5)));
    popMatrix();

    pushMatrix();
    translate(182,386); 
    rotate(radians(prior));
    rect(0,0,106,5,0,0,3,3);
    rotate(prior*(displacement-3)*cos(speed-35*time/2 - delay));
    popMatrix();

    pushMatrix();
    translate(160, 415); 
    rotate(prior*displacement*cos(speed*time/2 - delay));
    rect(0,0,107,2,0,0,3,3);
    ellipse(5, 17, scale, 70);
    rotate((prior+9)*displacement*cos(speed*time/2 - delay+2));
    ellipse(10, 1, scale+10, 8);
    ellipse(-10, -1, scale+130, 8);
    ellipse(35, 10, scale+130, 2);
    scale(prior*scale, scale);
    popMatrix();

    pushMatrix();
    rotate(prior*(displacement-4)*cos(speed*time/2 - delay+3.5));
    rect(196,457, 59,58,0,0,3,3);
    scale(prior*scale, scale+8);
    popMatrix();

    // Triangle
    pushMatrix();
    translate(182,386); 
    fill(17,20,11);
    rotate((prior*displacement)-.8*cos((speed*time)-1200/2 - delay-110));
    triangle(47,128, 392,119, 222,429);
    scale(prior*scale, scale+2);
    popMatrix();

    pushMatrix();
    translate(182,386); 
    fill(17,20,11);
    rotate((prior*displacement)+1*cos((speed*time)-1200/2 - delay-1));
    ellipse(47, 128, scale+6, 170);
    popMatrix();

}
