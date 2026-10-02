class Epi{
  float amp [];
  float freq [];
  float fase [];
  int n;
  
  Epi(int n_, float min_, float max_, float freq1, float freq2 ){
    n = n_;
    amp = new float [n];
    freq = new float [n];
    fase = new float [n];
    for(int i = 0; i<n; i++){
      amp[i] = random(min_, max_);
      freq[i] = random(freq1,freq2);
      if(random(1)>0.5){
        freq[i]*=-1;
      }
      fase[i] = random(TWO_PI);
    }
  }
  
  void display(float v_, PVector pos_){
    pushMatrix();
    translate(pos_.x,pos_.y);
    noFill();
    stroke(0,40);
    strokeWeight(3);
    beginShape();
    vertex(0,0);
    for(int i = 0; i<n; i++){
      float x = valCos(v_, i);
      float y = valSin(v_,i);
      vertex(x,y);
    }
    
    endShape();
    popMatrix();
  }
  
  
  float valSin(float v_, int in_){
    float resultado = 0;
    for(int i = 0; i<in_; i++){
      resultado+=sin(v_*freq[i]+fase[i])*amp[i];
    }
    return resultado;
  }
  
  float valCos(float v_, int in_){
    float resultado = 0;
    for(int i = 0; i<in_; i++){
      resultado+=cos(v_*freq[i]+fase[i])*amp[i];
    }
    return resultado;
  }
}



PImage gato;
float dr;
float dg;
Epi rojo;
Epi verde;
Epi azul;
void setup(){
  gato = loadImage("gatocubrebocas.png");
  size(587,587);
  println(gato.width);
  rojo = new Epi(8,0.5,1,0.1,1.3);
  verde = new Epi(8,0.5,1,0.1,1.3);
  azul = new Epi(8,0.5,1,0.1,1.3);
}

void draw(){
  dr+=0.1;
  dg+=0.05;
  image(gato,0,0);
  loadPixels();
  //for(int i = 0; i<pixels.length;i++){
  //  int x = i%width;
  //  int y = i/width;
  //  color v = pixels[i];
  //  float rojo = red(v);
  //  float verde = green(v);
  //  float azul = blue(v);
  //  float cR = sin(x*0.01+dr)*100;
  //  float cG = sin(y*0.02+dg)*40;
  //  rojo+=cR;
  //  verde+=cG;
  //  pixels [i] = color(rojo,verde,azul);
  //}
  
  
  //for(int i = 0; i<pixels.length; i++){
  //  color c = pixels[i];
  //  float r = red(c);
  //  float g = green(c);
  //  float b = blue(c);
  //  float vrojo = r +rojo.valSin(r*0.05 + dg, 8)*40;
  //  float vverde = g +verde.valSin(g*0.05 + dg, 8)*40;
  //  float vazul = b +azul.valSin(b*0.05 + dg, 8)*40;
  //  pixels[i] = color(vrojo,vverde,vazul);
  //}
  
  for(int i = 0; i<pixels.length; i++){
    int x = i%width;
    int y = i/width;
    float val = sin(y*0.5)*10;
    int v = round(val);
    int vv = constrain(i+v, 0, pixels.length-1);
    pixels[i] = pixels[vv];
    
  }
  updatePixels();
}
