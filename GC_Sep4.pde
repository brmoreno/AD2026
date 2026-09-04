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
  
  void display(){
    noFill();
    stroke(0);
    strokeWeight(3);
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
    for( int i = 0; i<n_; i++){
      for(PVector p: dirs){
        restart();
        p.rotate(TWO_PI/n_);
        pos.add(p);
        pvs.add(pos.copy());
      }
    }
    
  }
  
  
}

Tortuga una;

void setup(){
  background(255);
  size(900,900);
  una = new Tortuga();
 
  una.mover(100);  
  una.rota(HALF_PI-random(-0.5,0.5));
  una.mover(150);
  una.rota(-HALF_PI-random(-0.5,0.5));
  una.mover(50);
  una.rota(-HALF_PI-random(-0.5,0.5));
  una.mover(100);
  
  una.rota(-HALF_PI-random(-0.5,0.5));
  una.mover(150);
  una.itera(5);
una.display();
}
