class Nodo{
  PVector pos;
  float r;
  PVector v;
 
  
  Nodo(){
    pos = new PVector(random(width),random(height));
    r = random(50,150);
    v = PVector.random2D().mult(random(1,6)); 
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
    color c = gato.get(round(pos.x),round(pos.y));
    fill(c);
    noStroke();
    rect(ini.x,ini.y,1,1);
   }
}



PImage gato;
ArrayList <Agente> agentes;
ArrayList <Nodo> nodos;
void setup(){
  gato = loadImage("gatocubrebocas.png");
  size(587,587);
  agentes = new ArrayList <Agente> ();
  nodos = new ArrayList <Nodo> ();
  for(int i = 0; i<40; i++){
    nodos.add(new Nodo());
  }
  for(int i = 0; i<width; i++){
    for(int j = 0; j<height; j++){
      agentes.add(new Agente(i,j));
    }
  }
  
  
}

void draw(){
  for(Agente a:agentes){
    a.update(nodos);
    a.display();
  }
}
