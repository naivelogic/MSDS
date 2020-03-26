class window2 extends PApplet {

    int[] histdat = {554, 2, 4553, 523, 4887, 2,3,854,522, 324,56,1,23,354,878,51,52,5,63,0,5,0,1,185,8,9,99,15,55,3,331,11,5,1213,857,8,5,356,87,45231,5,65,20,25,60,30,80,2,1,0,90,100,180};


  window2() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    println("histagram of eyes");
    
  }

  void settings() {
    size(500, 200); 
  }


  void draw() {

      for (int x=0; x < histdat.length; x++) { 
            rect(25*x, height-histdat[x], 20, histdat[x]);
            }


  }

}