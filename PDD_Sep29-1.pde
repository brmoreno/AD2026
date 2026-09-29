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

ArrayList <PVector> pvs;

void setup(){
  size(900,900);
  background(255);
  
}


void draw(){
}

void mousePressed(){
  pvs = new ArrayList <PVector> ();
  pvs.add(new PVector(mouseX,mouseY));
}

void mouseDragged(){
  pvs.add(new PVector(mouseX,mouseY));
}

void mouseReleased(){
  Epi uno = new Epi(6,20,40,0.1,1.3);
  float v = 0;
  for(int i = 0; i<pvs.size()-1;i++){
    PVector p1 = pvs.get(i);
    PVector p2 = pvs.get(i+1);
    float dist = PVector.dist(p1,p2);
    for(int j = 0; j<dist+1; j++){
      PVector pos = PVector.lerp(p1,p2,dist/j);
      uno.display(v,pos);
      v+=0.2;
    }
  }
  noFill();
  
  
  beginShape();
  for(PVector p:pvs){
    vertex(p.x,p.y);
  }
  endShape();
}
