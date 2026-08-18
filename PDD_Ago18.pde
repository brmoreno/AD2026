class Particula{
  PVector pos;
  PVector v;
  float t ;
  float t2;
  float r;
  float g;
  float b;
  float osc[] = new float [4];
  float dosc[] = new float [4];
  
  Particula(){
    pos = new PVector(random(width),random(height));
    v = PVector.random2D();
    t = random(30,200);
    t2 = random(30,200);
    r = random(255);
    g = random(255);
    b = random(255);
    for(int i =0; i<4; i++){
      osc[i] = random(TWO_PI);
      dosc[i] = random(0.001,0.1);
    }
  }
  
  void mover(){
    pos.add(v);
    for(int i = 0; i<4; i++){
      osc[i]+=dosc[i];
    }
    if(pos.x<0 || pos.x>width){
      v.x*=-1;
    }
    
    if(pos.y<0 || pos.y>height){
      v.y*=-1;
    }
    
  }
  
  void display(){
    miCirculo(round(pos.x),round(pos.y),round(map(sin(osc[0]),-1,1,t,t2)), color(r*sin(osc[1]),g*sin(osc[2]),b*sin(osc[3])));
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
