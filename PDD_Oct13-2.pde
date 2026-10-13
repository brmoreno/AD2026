class Nodo{
  PVector v;
  PVector p;
  float r;
  float rojo;
  float verde;
  float azul;
  float tam;
  
  
  Nodo (float x_, float y_, float r_){
    p = new PVector (x_,y_);
    r = r_;
    rojo = random(100);
    verde = random(100);
    azul = random(100);
    v = PVector.random2D();
    tam = random(10);
  }
  
  Nodo(){
    p = new PVector(random(width),random(height));
    r = random(50,300);
    rojo = random(100);
    verde = random(100);
    azul = random(100); 
    v = PVector.random2D();
    tam = random(20);
  }
  
  void display(){
    fill(255,0,0,30);
    noStroke();
    //circle(p.x,p.y,r*2);
    stroke(0,0,255);
    p.add(v);
    if(p.x<0|| p.x>width){
      v.x*=-1;
    }
    if(p.y<0|| p.y>height){
      v.y*=-1;
    }
  }
}

class Agente {
  PVector p;
 
  
  Agente(){
    p = new PVector(random(width),random(height));
  
  }
  
  void display(ArrayList <Nodo> nodos){
    noStroke();
    fill(calcularColor(nodos));
    circle(p.x,p.y,calcularTam(nodos));
  }
  
  
  color calcularColor(ArrayList <Nodo> nodos){
    float rojo = 0;
    float verde = 0; 
    float azul = 0;
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        rojo += n.rojo*inte;
        verde += n.verde*inte;
        azul += n.azul*inte;
      }
    }    
    return (color(rojo,verde,azul));
  }
  
  float calcularTam(ArrayList <Nodo> nodos){
    float t = 0;
    for(Nodo n: nodos){
      float dist = dist(p.x,p.y, n.p.x,n.p.y);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        t += n.tam*inte;
        
      }
    }    
    return (t);
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
  for(int i = 0; i<2000; i++){
    agentes.add(new Agente());
  }
  background(255);
}

void draw(){
  background(255);
  for(Nodo n: nodos){
    n.display();
  }
  //if(mousePressed){
  for(Agente a:agentes){
    //a.mover(nodos);
  }
  //}
  
  for(Agente a:agentes){
    a.display(nodos);
  }
}
