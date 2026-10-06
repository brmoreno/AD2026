class BezierAPoligono{
  ArrayList <PVector> pvs;
  
  BezierAPoligono(){
    pvs = new ArrayList <PVector>();
  }
  
  void agregarPVector(float x_, float y_){
    pvs.add(new PVector(x_,y_));
  }
  
  void display1(){
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for(PVector p:pvs){
      vertex(p.x,p.y);
    }
    endShape(CLOSE);    
  }
  
  void display2(){
    noFill();
    strokeWeight(3);
    stroke(255,0,0);
    if(pvs.size()>=2){
      for(int i = 1; i<pvs.size()-1;i++){
        PVector act = pvs.get(i);
        PVector ant = pvs.get(i-1);
        PVector sig = pvs.get(i+1);
        PVector int1 = PVector.lerp(ant,act,0.5);
        PVector int2 = PVector.lerp(act,sig,0.5);
        bezier(int1.x,int1.y,act.x,act.y,act.x,act.y,int2.x,int2.y);
      }
    }
  }
}

BezierAPoligono uno;

void setup(){
  size(900,900);
  uno = new BezierAPoligono();
}

void draw(){
 background(255);
 //uno.display1();
 uno.display2();
}

void mousePressed(){
  uno.agregarPVector(mouseX,mouseY);
}

