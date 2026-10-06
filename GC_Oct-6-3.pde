class Nodo{
  PVector p;
  boolean activo;
  
  Nodo(float x_, float y_){
    p = new PVector(x_,y_);
    activo = false;
  }
  
  void display(){
    circle(p.x,p.y,20);
  }
  
  void mover(){
    if(activo){
      p.x = mouseX;
      p.y = mouseY;
    }
  }
}

Nodo [] nodos;
void setup(){
  nodos = new Nodo[4];
  size(900,900);
  nodos[0] = new Nodo(100,height/2);
  nodos[3] = new Nodo(800,height/2);
  nodos[1] = new Nodo(100,height/4);
  nodos[2] = new Nodo(800,height/4);
}

void draw(){
  noFill();
  background(255);
  for(Nodo n: nodos){
   n.display();
   n.mover();
  }
  
  bezier(nodos[0].p.x,nodos[0].p.y,nodos[1].p.x,nodos[1].p.y,nodos[2].p.x,nodos[2].p.y,nodos[3].p.x,nodos[3].p.y);
  for(float i = 0; i<1; i+= 0.1){
    float x1 = bezierPoint(nodos[0].p.x,nodos[1].p.x,nodos[2].p.x,nodos[3].p.x,i);
    float y1 = bezierPoint(nodos[0].p.y,nodos[1].p.y,nodos[2].p.y,nodos[3].p.y,i);
    float x2 = bezierPoint(nodos[0].p.x,nodos[1].p.x,nodos[2].p.x,nodos[3].p.x,i+0.1);
    float y2 = bezierPoint(nodos[0].p.y,nodos[1].p.y,nodos[2].p.y,nodos[3].p.y,i+0.1);
    PVector uno = new PVector(x1,y1);
    PVector dos = new PVector(x2,y2);
    dos.sub(uno);
    
    triangulo(x1,y1,dos.heading());
  }
}


void triangulo(float x_, float y_, float a_){
  pushMatrix();
  translate(x_,y_);
  rotate(a_);
  triangle(0,30,0,-30,60,0);
  popMatrix();
}

void mousePressed(){
  for(Nodo n:nodos){
    float dist = dist(mouseX,mouseY,n.p.x,n.p.y);
    if(dist<10){
      n.activo = true;
      break;
    }
  }
}

void mouseReleased(){
  for(Nodo n:nodos){
    n.activo = false;
  }
}
