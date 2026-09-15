class Epi{
  float amp [];
  float freq [];
  float acum [];
  color c[];
  
  Epi(int n_){
    amp = new float[n_];
    freq = new float[n_];
    acum = new float [n_];
    c = new color[n_];
    for(int i = 0; i< n_; i++){
      amp[i] = random(50,200);
       freq [i] = random(-0.05, 0.05);
       acum[i] = random(TWO_PI);
       c[i] = color(random(255),random(255),random(255));
    }
  }
  
  void mover(){
    for(int i = 0; i<acum.length;i++){
      acum[i]+=freq[i];
    }
  }
  
  void display(){
    float x = 0;
    float y = 0;
    float x2 = 0;
    float y2 = 0;
    for(int i =0; i<freq.length -1; i++){
      x2 = x + cos(acum[i+1])*amp[i]; 
      y2 = y + sin(acum[i+1])*amp[i];
      stroke(c[i],120);
      line(x,y,x2,y2);
      x = x2;
      y = y2;
    }
  }  
}

Epi uno;
float x;
void setup(){
  size(900,900);
  background(255);
  uno = new Epi(10);
}

void draw(){
  x+=0.5;
  translate(x,height/2);
  uno.mover();
  uno.display();
}
