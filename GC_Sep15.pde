class Tortuga{
  PVector pos;
  PVector dir;
  ArrayList <PVector> pvs;
  ArrayList <PVector> dirs;
  PVector centroCaja;
  PVector centroVect;
  float ancho;
  float alto;
  PVector tras = new PVector(0,0);
  float rota = 0;
  float escala = 1;
  
  Tortuga(){
    pos = new PVector(width/2, height/2);
    dir = PVector.fromAngle(-HALF_PI);
    pvs = new ArrayList <PVector> ();
    dirs = new ArrayList <PVector> ();
    pvs.add(pos.copy());
    centroCaja = new PVector();
    centroVect = new PVector();
  }
  
  void drawPoints(){
    for(PVector p:pvs){
      circle(p.x,p.y,5);
    }
  }
  void display(){
    noFill();
    stroke(0);
    strokeWeight(2);
    
    ArrayList <PVector> pvsCopia = new ArrayList <PVector> ();
    
    for(PVector p:pvs){
        pvsCopia.add(p.copy());      
    }
    
    for(PVector p: pvsCopia){
      p.rotate(rota);
      p.mult(escala);
      p.add(tras);
    }
    beginShape();
      for(PVector p:pvsCopia){
        vertex(p.x,p.y);
      }
    endShape();
    noStroke();
    fill(255,0,0);
    circle(centroCaja.x,centroCaja.y,10);
    fill(0,0,255);
    circle(centroVect.x,centroVect.y,10);
  }
  
  void rota(float v_){
    dir.rotate(v_);
  }
  
  void restart(){
    dir.setHeading(-HALF_PI);
  }
  
  void mover(float v_){
    dir.setMag(v_);
    pos.add(dir);
    pvs.add(pos.copy());
    dirs.add(dir.copy());
  } 
  
  void itera(int n_){
    for( int i = 0; i<n_-1; i++){
      for(PVector p: dirs){
        p.rotate(TWO_PI/n_);
        pos.add(p);
        pvs.add(pos.copy());
      }
    }    
  }
  
  void itera2(int n_){    
    dirs = new ArrayList <PVector> ();
    for(int i = 0; i<pvs.size()-1; i++){
      PVector p = pvs.get(i+1).copy();
      p.sub(pvs.get(i));
      dirs.add(p);
    }
    pos = pvs.get(pvs.size()-1).copy();
    println(pos);
    itera(n_);
  }
  
  void itera3(int n_){    
    dirs = new ArrayList <PVector> (); 
    for(int i =pvs.size()-1; i>0; i--){
      PVector p = pvs.get(i-1).copy();
      p.sub(pvs.get(i));
      p.x*=-1;
      dirs.add(p);
    }
    pos = pvs.get(pvs.size()-1).copy();
    for(PVector p: dirs){
        pos.add(p);
        pvs.add(pos.copy());
      }
    itera2(n_);
    calcularCentros();
    modificarVecs();
  }
  
  void calcularCentros(){
    centroCaja = new PVector();
    centroVect = new PVector(0,0);
    float minX = 1000, maxX = -1000, minY = 1000, maxY = -1000;
    for(int i = 0; i<pvs.size(); i++){
      centroVect.add(pvs.get(i));
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
    alto = maxY-minY;
    ancho = maxX - minX;
    
    centroVect.div(pvs.size());
    centroCaja = new PVector(minX+ancho/2,minY+alto/2);
  }
  
  void modificarVecs(){
    for(int i = 0; i<pvs.size();i++){
      pvs.get(i).sub(centroVect);
    }
  }
}

Tortuga una;
boolean estado;
float difX, difY;
void setup(){
  background(255);
  size(900,900);
  una = new Tortuga();
 
}

void draw(){
  translate(difX,difY);
  background(255);
  
  if(!estado) una.drawPoints();
  else una.display();
  una.tras = new PVector(mouseX,mouseY);
}

void mousePressed(){
  una.pvs.add(new PVector(mouseX,mouseY));
}

void keyPressed(){
  if(key == 'a'){
  una.itera3(8);
  estado = true;
  println(una.pvs.size());
  
  }
  
  if(key == 'z'){
    una.rota+=0.05;
  }
  
  if(key == 'x'){
    una.escala+=0.1;
  }
  if(key == 'c'){
    una.escala-=0.1;
  }
  
  
}
