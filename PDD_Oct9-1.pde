class Nodo{
  PVector p;
  float r;
  PVector v;
  
  Nodo (float x_, float y_, float r_){
    p = new PVector (x_,y_);
    r = r_;
    v = PVector.random2D().mult(random(1,3));
  }
  
  Nodo(){
    p = new PVector(random(width),random(height));
    r = random(50,300);
    v = PVector.random2D().mult(random(1,3)); 
  }
  
  void display(){
    fill(255,0,0,30);
    noStroke();
    circle(p.x,p.y,r*2);
    stroke(0,0,255);
    line(p.x,p.y,p.x+v.x,p.y+v.y);
  }
}

class Agente {
  PVector p;
  
  Agente(){
    p = new PVector(random(width),random(height));
  }
  
  void display(){
    noStroke();
    fill(0,40);
    circle(p.x,p.y,3);
  }
  
  
  void mover(ArrayList <Nodo> nodos){
    PVector v = new PVector(0,0);
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        PVector dire = n.v.copy().mult(inte);
        v.add(dire);
      }
    }    
    p.add(v);
  }

}

ArrayList <Nodo> nodos;
ArrayList <Agente> agentes;
void setup(){
  size(900,900);
  nodos = new ArrayList <Nodo> ();
  nodos.add(new Nodo(width/2, height/2,150));
  for(int i = 0; i<100; i++){
    nodos.add(new Nodo());
  }
  agentes = new ArrayList <Agente>();
  for(int i = 0; i<1000; i++){
    agentes.add(new Agente());
  }
  background(255);
}

void draw(){
  
  for(Nodo n: nodos){
    //n.display();
  }
 
  for(Agente a:agentes){
    a.mover(nodos);
  }
  
  
  for(Agente a:agentes){
    a.display();
  }
}
