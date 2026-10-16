class Nodo{
  PVector pos;
  float r;
  PVector v;
 
  
  Nodo(){
    pos = new PVector(random(width),random(height));
    r = random(50,300);
    v = PVector.random3D().mult(random(1,6)); 
  }
  
  void display(){
    fill(255,0,0,30);
    noStroke();
    circle(pos.x,pos.y,r*2);
    stroke(0,0,255);
  }
}

class Agente {
  PVector ini;
  PVector pos;
  
  Agente(float x_, float y_){
    ini = new PVector(x_,y_);
    pos = new PVector(x_,y_);
  }
  
  void update(ArrayList <Nodo> nodos_){
    PVector dir = new PVector();
    for(Nodo n:nodos_){
      float dist = PVector.dist(pos,n.pos);
      if(dist<n.r){
        float inte  = map(dist,0,n.r,1,0);
        PVector dl = n.v.copy().mult(inte);
        dir.add(dl);
      }
    }
    pos.add(dir);
   }
   
   void display(){
     circle(pos.x,pos.y,5);
   }
}


ArrayList <Nodo> nodos;
ArrayList <Agente> agentes;
void setup(){
  size(900,900);
  nodos = new ArrayList <Nodo> ();
  agentes = new ArrayList <Agente> ();
  for(int i = 0; i <100; i++){
    nodos.add(new Nodo());
  }
  
  for(int i = 0 ; i< width; i+= 1){
    for(int j = 0; j< height; j+=1){
      agentes.add(new Agente(i,j));
    }
  }
  background(255);
}


void draw(){
  for(Agente a:agentes){
    a.update(nodos);
    PVector dist = PVector.sub(a.ini,a.pos);
    float rojo  = 127 + dist.x;
    float verde = 127 + dist.y;
    float azul = 127 + dist.z;
    color c = color(rojo,verde,azul);
    fill(c);
    noStroke();
    rect(a.ini.x,a.ini.y,1,1);
  }
  
  
  
  
  
}
