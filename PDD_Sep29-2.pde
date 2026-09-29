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
  
  
  float valSin(float v_){
    float resultado = 0;
    for(int i = 0; i<n; i++){
      resultado+=sin(v_*freq[i]+fase[i])*amp[i];
    }
    return resultado;
  }
  
  float valCos(float v_){
    float resultado = 0;
    for(int i = 0; i<n; i++){
      resultado+=cos(v_*freq[i]+fase[i])*amp[i];
    }
    return resultado;
  }
}


Epi uno;
ArrayList <PVector>pvs;
ArrayList <PVector>pvs2;
ArrayList <PVector>pvs3;
ArrayList <PVector>pvs4;
void setup(){
  size(900,900);
  uno = new Epi(7,20,40,0.1,1.3);
  pvs = new ArrayList <PVector> ();
  for(int i = 0; i<500; i++){
    PVector p = new PVector(uno.valCos(i*0.05),uno.valSin(i*0.05));
    pvs.add(p);
  }
  for(int i = 0; i<pvs.size();i++){
    pvs.get(i).add(i*0.5,0);
  }
  float minX = 1000;
  float minY = 1000;
  float maxX = -1000;
  float maxY = -1000;
  for(int i = 0; i<pvs.size();i++){
    PVector p= pvs.get(i);
    if(p.x<minX){
      minX = p.x;
    }
    if(p.y<minY){
      minY = p.y;
    }
    if(p.x>maxX){
      maxX = p.x;
    }
    if(p.y>maxY){
      maxY = p.y;
    }
  }
  
  float ancho = maxX-minX;
  float alto = maxY - minY;
  PVector esq = new PVector (minX,minY);
  
  for(PVector p:pvs){
    p.sub(esq);
  }
  
  pvs2 = new ArrayList <PVector> ();
  pvs3 = new ArrayList <PVector> ();
  pvs4 = new ArrayList <PVector> ();
  for(PVector p:pvs){
    
    PVector pCopia = p.copy();
    pCopia.x*=-1;
    pCopia.add(ancho*2,0);
    pvs2.add(pCopia);
    
    PVector pCopia2 = p.copy();
    pCopia2.y*=-1;
    pCopia2.add(0,alto*2);
    pvs3.add(pCopia2);
    
    PVector pCopia3 = pCopia.copy();
    pCopia3.y*=-1;
    pCopia3.add(0,alto*2);
    pvs4.add(pCopia3);
    
  }
}

void draw(){
  background(255);
  translate(mouseX,mouseY);
  noFill();
  beginShape();
  for(PVector p: pvs){
    vertex(p.x,p.y);
  }
  endShape();
  
  beginShape();
  for(PVector p: pvs2){
    vertex(p.x,p.y);
  }
  endShape();
  
  beginShape();
  for(PVector p: pvs3){
    vertex(p.x,p.y);
  }
  endShape();
  
  beginShape();
  for(PVector p: pvs4){
    vertex(p.x,p.y);
  }
  endShape();
}
