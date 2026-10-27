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
  color c;
  float dura;
  int contador;
  float ti;
  float tf;
  
  Agente(){
    p = new PVector(random(width),random(height));
    d = PVector.random2D().mult(0.2);
    c = gato.get(round(p.x),round(p.y));
    dura = random(50,400);
    ti = random(5,50);
    tf = random(5,50);
  }
  
  void display(){
    if(contador<dura){
      noStroke();
      fill(c,40);
      float tam = map(contador,0,dura,ti,tf);
      circle(p.x,p.y,tam);
    }
    contador ++;
  }
  
  
  void mover(ArrayList <Nodo> nodos){
    PVector v = new PVector(0,0);
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        PVector dire = PVector.sub(n.p,p).normalize();
        
        
        dire.rotate(HALF_PI);
        dire.mult(inte);
        dire.mult(n.f);
        v.add(dire);
      }
    }  
    v.normalize();
    p.add(v);
    color actual = gato.get(round(p.x),round(p.y));
    c = lerpColor(c,actual,0.01);
  }
  

}

ArrayList <Nodo> nodos;
ArrayList <Agente> agentes;
PImage gato;

void setup(){
  size(900,900);
  gato = loadImage("gatocubrebocas.png");
  gato.resize(width,height);
  nodos = new ArrayList <Nodo> ();
  nodos.add(new Nodo(width/2, height/2,150,3));
  for(int i = 0; i<100; i++){
    nodos.add(new Nodo());
  }
  agentes = new ArrayList <Agente>();
  for(int i = 0; i<1000; i++){
    agentes.add(new Agente());
  }
  background(255);
  

  
 
  for(Agente a:agentes){
    float hasta = a.dura;
    for(int i = 0; i<hasta; i++){
    a.mover(nodos);
    a.display();
    }
  }
}
