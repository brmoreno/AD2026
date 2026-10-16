class Nodo{
  PVector pos;
  float r;
  float f;
  PVector v;
 
  
  Nodo(){
    pos = new PVector(random(-width/2,width/2),random(-height/2,height/2));
    r = random(50,300);
    f = random(50,200);
    v = PVector.random2D();
    if(random(1)<0.5){
      f*=-1;
    }
  }
  
  void display(){
    fill(255,0,0,30);
    noStroke();
    circle(pos.x,pos.y,r*2);
    stroke(0,0,255);
  }
  
  void update(){
    pos.add(v);
    if(pos.x>width/2 || pos.x<-width/2){
      v.x*=-1;
    }
    if(pos.y>height/2 || pos.y<-height/2){
      v.y*=-1;
    }
  }
}

class Agente{
  
  PVector pos;
  float z;
  
  Agente(float x_, float y_){
    pos = new PVector(x_,y_);
    z = 0;
  }
  
  void update(ArrayList <Nodo> nodos_){
    float dz = 0;
    for(Nodo n:nodos_){
      float dist = PVector.dist(pos,n.pos);
      if(dist<n.r){
        float inte = map(dist,0,n.r,1,0);
        dz+= n.f*inte;
      }
    }
    z = dz;
  }
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y,z);
    box(20);
    fill(0,180,0);
    noStroke();
    popMatrix();
  }
}


ArrayList <Agente> agentes;
ArrayList <Nodo> nodos;
void setup(){
  size(900,900,P3D);
  agentes = new ArrayList <Agente> ();
  for(int i=-width/2; i<width/2; i+=10){
    for(int j = -height/2; j<height/2; j+=10){
      agentes.add(new Agente(i,j));
    }
  }
  nodos = new ArrayList <Nodo> ();
  for(int i = 0; i<100; i++){
    nodos.add(new Nodo());
  }
}

void draw(){
  background(0);
  lights();
  pushMatrix();
  translate(width/2,height/2);
  rotateX(mouseX*0.01);
  rotateY(mouseY*0.01);
  for(Nodo n:nodos){
    n.update();
  }
  for(Agente a:agentes){
    a.update(nodos);
    a.display();
  }
  popMatrix();
}
