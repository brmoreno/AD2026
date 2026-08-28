class Brown{
  PVector pos;
  PVector v;
  float r = 0.1;
  float dr;
  ArrayList <PVector> pvs;
  int n ;

  Brown(float v_, int n_){
    n = n_;
    pos = new PVector(0,0);
    v = PVector.random2D().mult(v_);
    pvs = new ArrayList <PVector>();
    for(int i = 0; i<n; i++){
      pvs.add(pos.copy());
      mover();
    }
  }
    
  void mover(){
    pos.add(v);
    v.setHeading(random(TWO_PI));
    //v.rotate(r);
    //r+=dr;
    //dr = random(-0.01,0.01);
  } 
}

Brown una;
float r;
float s = 1;
void setup(){
  size(900,900);
  una = new Brown(1,5000);
  background(255);
  
}


void draw(){
  r+=0.01;
  translate(width/2,height/2);
  rotate(r);
  stroke(0);
  strokeWeight(0.5);
  ArrayList <PVector> pvs = new ArrayList <PVector> ();
  
  for(PVector p : una.pvs){
    pvs.add(p.copy());
    
  }
  
  float minX =100,maxX =-100,minY = 100,maxY = -100;
  for(int i = 0; i<pvs.size(); i++){
    PVector p = pvs.get(i);
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
  
  float alto = width*0.5/(maxY-minY);
  float ancho = height*0.5/(maxX - minX);
  
  for(int i = 0 ; i<pvs.size();i++){
    pvs.get(i).add(-minX,-minY);
    pvs.get(i).x*=ancho;
    pvs.get(i).y*=alto;
       
  }
  
  for(int i = 0; i<pvs.size();i++){
   pvs.get(i).mult(s); 
   pvs.get(i).rotate(r);
   pvs.get(i).add(mouseX,mouseY);  
  }
  
  
  
  
  for(int i = 0; i<pvs.size()-1;i++){
    PVector actual = pvs.get(i);
    PVector siguiente = pvs.get(i+1);
    stroke(0,20);
    strokeWeight(0.5);
    line(actual.x,actual.y,siguiente.x,siguiente.y);
    noStroke();
    fill(0,0,120,20);
    //circle(actual.x,actual.y,15);
  } 
}

void keyPressed(){
  if(key == 'a'){
    s-=0.1;
  }
  if(key == 's'){
    s+=0.1;
  }
  
  if(key == 'z'){
    r-=0.1;
  }
  if(key == 'x'){
    r+=0.1;
  }
}
