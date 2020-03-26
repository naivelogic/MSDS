class colorh {
    PImage[] eye = new PImage[3];

    colorh() {
        registerMethod("show", this);
        for (int i = 0; i < eye.length; i++) {
        eye[i] = loadImage("eye_exam_0" + i + ".jpg");
        }
    }
    void show() {
        image(eye[2], 0, 0);   
    }

}


