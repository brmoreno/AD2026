class Brown{
  PVector pos;
  PVector v;

  Brown(float x_, float y_, float v_){
    pos = new PVector(x_,y_);
    v = PVector.random2D().mult(v_);
  }
  
  void display(){
    noStroke();
    fill(255,0,0,10);
    circle(pos.x,pos.y,20);
  }
  
  void mover(){
    pos.add(v);
    v.setHeading(random(TWO_PI));
  }
  
}

Brown una;
void setup(){
  size(900,900);
  una = new Brown(width/2,height/2,5);
  background(255);
  for(int i = 0; i<50000;i++){
    una.display();
    una.mover();
  }
}

