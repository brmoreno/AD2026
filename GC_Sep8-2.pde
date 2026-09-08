class Tortuga{
  PVector pos;
  PVector dir;
  ArrayList <PVector> pvs;
  ArrayList <PVector> dirs;
  
  Tortuga(){
    pos = new PVector(width/2, height/2);
    dir = PVector.fromAngle(-HALF_PI);
    pvs = new ArrayList <PVector> ();
    dirs = new ArrayList <PVector> ();
    pvs.add(pos.copy());
  }
  
  void drawPoints(){
    for(PVector p:pvs){
      circle(p.x,p.y,5);
    }
  }
  void display(){
    noFill();
    //fill(255,0,0);
    stroke(0);
    strokeWeight(0.5);
    beginShape();
      for(PVector p:pvs){
        vertex(p.x,p.y);
      }
    endShape();
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
  }
}

Tortuga una;
boolean estado;
void setup(){
  background(255);
  size(900,900);
  una = new Tortuga();
 
}

void draw(){
  background(255);
  if(!estado) una.drawPoints();
  else una.display();
}

void mousePressed(){
  una.pvs.add(new PVector(mouseX,mouseY));
}

void keyPressed(){
  una.itera3(6);
  estado = true;
  println(una.pvs.size());
}
