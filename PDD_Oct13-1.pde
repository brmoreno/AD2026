class Nodo{
  PVector p;
  float r;
  float f;
  
  Nodo (float x_, float y_, float r_, float f_){
    p = new PVector (x_,y_);
    r = r_;
    f = f_;
  }
  
  Nodo(){
    p = new PVector(random(width),random(height));
    r = random(50,300);
    f = random(-3,3); 
  }
  
  void display(){
    fill(255,0,0,30);
    noStroke();
    circle(p.x,p.y,r*2);
    stroke(0,0,255);

  }
}

class Agente {
  PVector p;
  PVector d;
  
  Agente(){
    p = new PVector(random(width),random(height));
    d = PVector.random2D().mult(0.2);
  }
  
  void display(){
    noStroke();
    fill(0,40);
    circle(p.x,p.y,5);
  }
  
  
  void mover(ArrayList <Nodo> nodos){
    PVector v = new PVector(0,0);
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        PVector dire = PVector.sub(n.p,p).normalize();
        if(n.f>0){
          //dire.rotate(HALF_PI);
        }
        else{
          //dire.rotate(-HALF_PI);
        }
        
        dire.rotate(HALF_PI);
        dire.mult(inte);
        dire.mult(n.f);
        v.add(dire);
        v.add(d);
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
  nodos.add(new Nodo(width/2, height/2,150,3));
  for(int i = 0; i<100; i++){
    nodos.add(new Nodo());
  }
  agentes = new ArrayList <Agente>();
  for(int i = 0; i<2000; i++){
    agentes.add(new Agente());
  }
  background(255);
}

void draw(){
  
  for(Nodo n: nodos){
    //n.display();
  }
  //if(mousePressed){
  for(Agente a:agentes){
    a.mover(nodos);
  }
  //}
  
  for(Agente a:agentes){
    a.display();
  }
}
