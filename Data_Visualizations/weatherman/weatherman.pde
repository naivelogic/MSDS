XML xml;
PImage tx;

float temperature = 0.0;
float wind_gust_mph = 0.0;
String city = "dallas";
int zipcode = 75025;
PFont f;

int wind_x;
int wind_y;


void setup() {
  xml = loadXML("https://w1.weather.gov/xml/current_obs/KADS.xml");
  //saveXML(xml, "subset.xml");
  //XML[] children = xml.getChildren("temp_f");
  XML temp = xml.getChild("temp_f");
  println(temp.getFloatContent());
  //int temp = weather_temp.getContext(); 
  
  XML inquired_loc = xml.getChild("location");
  println(inquired_loc.getContent());
  
  XML wind_mph = xml.getChild("wind_gust_mph");
  println(wind_mph.getFloatContent());
  
  // Weatherman information 
  temperature = temp.getFloatContent();
  city = inquired_loc.getContent();
  wind_gust_mph = wind_mph.getFloatContent();
  
  println(temperature, city);
  
  size(600,371);
  tx = loadImage("dallas.jpg");
  f = createFont("Arial", 20);
  
  //variables
  wind_y = 0;
  wind_x = 0;
}

void draw() {
  background(tx);
  textFont(f, 20);
  fill(0);
  
  // display
  text("Zipcode" + zipcode, 10,50);
  text("Temp: " + temperature, 10, 70);
  
  
  
  if (mousePressed==true) {
      fill(0, 0, 255);
      stroke(0, 0, 255);  
      wind_x = 90;
      wind_y = 45;
      ellipse(mouseX, mouseY, wind_x, wind_y);
      line(mouseX, mouseY, mouseX+wind_x, mouseY+wind_y);
      
      fill(173, 216, 230);
      strokeWeight(4);
      beginShape();
      vertex(120, 120);
      quadraticVertex(480, 420, 160, 350);
      endShape();
      
      fill(0);
      text("WIND GUST: " + wind_gust_mph + "MPH", 100, 300);
    }
    
 
}
