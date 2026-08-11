int vx;


void setup(){
  size(900,900);
  vx = 0;
}

void draw(){
  background(0);
  miRect(vx,800,400,200,color(255));
  miRect(300,500,100,100,color(255,0,0)); 
  vx-=1;
  println(vx);
}

void miRect(int x_, int y_, int w_, int h_, color c_){  
  loadPixels();
  for(int j = y_<0? 0:y_; j<y_+h_ && j<height; j++){
    int y = j*width;
    for(int i = x_<0? 0:x_; i<x_+w_ && i <width ; i++){
      pixels[y+i] = c_;
    }
  }
  updatePixels();
  
}
