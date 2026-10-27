class Nodo{
  PVector p;
  float r;
  PVector d;
  
  Nodo (float x_, float y_, float r_, float f_){
    p = new PVector (x_,y_);
    r = r_;
    d = PVector.random2D().mult(random(1,2));
  }
  
  Nodo(){
    p = new PVector(random(width),random(height));
    r = random(50,300);
    d = PVector.random2D().mult(random(1,5)); 
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
  float t;
  boolean replica;
  PVector da;
  int mod = 10;
  
  Agente(float x_, float y_, float t_, float dura_, PVector d_, boolean r_, color c_){
    p = new PVector(x_,y_);
    d = d_;
    c = c_;
    dura = dura_;
    t = t_;
    replica = r_;
    mod = floor(random(10,30));
  }
  
  void display(){
    if(contador<dura){
      noStroke();
      fill(c);
      circle(p.x,p.y,t);
      float duraL = map(contador,0,dura,dura/3,dura/40);
      if(contador%mod == 0 && contador > 1 && replica){
        Agente nuevo = new Agente(p.x,p.y,t/2, duraL, da.copy().rotate(HALF_PI),false,c);
        agentes2.add(nuevo);
        Agente nuevo2 = new Agente(p.x,p.y,t/2, duraL, da.copy().rotate(-HALF_PI),false,c);
        agentes2.add(nuevo2);

      }
    }
    contador ++;
  }
  
  
  void mover(ArrayList <Nodo> nodos){
    PVector v = new PVector(0,0);
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        PVector dire = n.d.copy().mult(inte);
        v.add(dire);
      }
    }  
    v.add(d);
    v.normalize();
    da = v.copy();
    p.add(v);
    
  }
  

}

ArrayList <Nodo> nodos;
ArrayList <Agente> agentes;
ArrayList <Agente> agentes2;
PImage gato;

void setup(){
  size(900,900);
  gato = loadImage("gatocubrebocas.png");
  gato.resize(width,height);
  nodos = new ArrayList <Nodo> ();
  nodos.add(new Nodo(width/2, height/2,150,3));
  for(int i = 0; i<50; i++){
    nodos.add(new Nodo());
  }
  agentes = new ArrayList <Agente>();
  agentes2 = new ArrayList <Agente>();
  for(int i = 0; i<50; i++){
    agentes.add(new Agente(random(width),random(height), 5, 200,  new PVector(0,1), true,color(0,random(80,255),random(100))));
  }
  background(255);
  

  
}
void draw(){
  for(Agente a:agentes){   
    a.mover(nodos);
    a.display();
  }
  
  for(Agente a:agentes2){   
    a.mover(nodos);
    a.display();
  }
}
