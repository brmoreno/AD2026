int vx;

void setup(){
  size(900,900);
  vx = 0;
  background(0);
  for(int i = 0; i<100; i++){
    int x = round(random(width));
    int y = round(random(height));
    int r = round(random(20,200));
    color c= color(random(255),random(255),random(255));
    miCirculo(x,y,r,c);    
  }
  miCirculo(450,450,00,color(255,0,0));
}

void miRect(int x_, int y_, int w_, int h_, color c_){  
  loadPixels();
  for(int j = y_<0? 0:y_; j<y_+h_ && j<height; j++){
    int y = j*width;
    for(int i = x_<0? 0:x_; i<x_+w_ && i <width ; i++){     
      pixels[y+i] += c_;
      int colorInicial = pixels[y+i];
      float rojoI = red(colorInicial);
      float verdeI = green(colorInicial);
      float azulI = blue(colorInicial);
      rojoI+=red(c_);
      verdeI+=green(c_);
      azulI+=blue(c_);
      pixels[y+i] = color(rojoI,verdeI,azulI);
    }
  }
  updatePixels(); 
}



void miCirculo(int x_, int y_, int r_, color c_){  
  loadPixels();
  for(int j = y_-r_<0? 0:y_-r_; j<y_+r_ && j<height; j++){
    int y = j*width;
    for(int i = x_-r_<0? 0:x_-r_; i<x_+r_ && i <width ; i++){
      float dist = dist(i,j,x_,y_);
      if(dist<r_){
        int colorInicial = pixels[y+i];
        float rojoI = red(colorInicial);
        float verdeI = green(colorInicial);
        float azulI = blue(colorInicial);
        float inten = map(dist,0,r_,1,0);
        rojoI+=red(c_)*inten;
        verdeI+=green(c_)*inten;
        azulI+=blue(c_)*inten;
        pixels[y+i] = color(rojoI,verdeI,azulI);
      }
    }
  }
  updatePixels(); 
}

void draw(){
}
void mousePressed(){
  loadPixels();
  int x = mouseX;
  int y = mouseY;
  int v = y*width+x;
  println(pixels[v]);
}
