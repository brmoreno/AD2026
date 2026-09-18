class Fourier{
  float freq[];
  float amp [];
  float fase[];
  int n;
  
  Fourier(int n_, float minF, float maxF, float minA, float maxA){
    n = n_;
    freq = new float[n];
    amp = new float[n];
    fase = new float[n];
    for(int i = 0; i< n; i++){
      freq[i] = random(minF,maxF);
      amp[i] = random(minA,maxA);
      fase[i] = random(TWO_PI);
    }
  }
  
  float val(float v_){
    float val = 0;
    for(int i = 0; i<n;i++){
      val += sin(v_*freq[i] + fase[i])*amp[i]; 
    }
    return val;
  }
  
}

Fourier rojo;
Fourier verde;
Fourier azul;
Fourier pos;

void setup(){
 size(2000,800);

 
 rojo = new Fourier(8,0.1,1.5,.1,2);
 verde = new Fourier(8,0.1,1.5,.1,2);
 azul = new Fourier(8,0.1,1.5,.1,2);
 pos = new Fourier(8,0.1,1.5,0.1,2);
 
}

void draw(){
  background(255);
  for(float i = 0; i< width; i+=0.1){
    float an = pos.val(i*0.05)*HALF_PI;
    float x = i + sin(an)*200;
    float y = height/2 +cos(an)*200;
    float r = 127 + rojo.val(i*0.01)*50;
    float g = 127 + verde.val(i*0.01)*50;
    float b = 127 + azul.val(i*0.01)*50; 
    noStroke();
    fill(r,g,b);
    circle(x,y,50);
  }
  
  
}
