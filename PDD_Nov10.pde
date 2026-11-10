import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList <Box> boxes;
ArrayList <Nodo> nodos;
Limite l;


void setup(){
  size(900,900);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boxes = new ArrayList <Box> ();
  box2d.setGravity(0,0);
  l = new Limite(width/2,height-30,width,30);
  for(int i = 0; i<300;i++){
    boxes.add(new Box(random(width), random(height-50),20,20));
  }
  nodos = new ArrayList <Nodo> ();
  for(int i = 0;i<50;i++){
    nodos.add(new Nodo());
  }
}


void draw(){
  if(mousePressed){
  box2d.step();
  }
  background(255);
  
  
  for(Nodo n:nodos){
    //n.display();
  }
  
  for(Box b:boxes){
    b.display();
    b.nodos(nodos);
  }
  l.display();
  
  println(boxes.size());
}

void keyPressed(){
  if(key == 'a'){
     box2d.setGravity(0,0);
  }
  if(key == 's'){
     box2d.setGravity(0,10);
  }
  if(key == 'd'){
     box2d.setGravity(0,-10);
  }
}

class Box{
  float w;
  float h;
  Body b;
  
  Box(float x_, float y_, float w_, float h_){
    w = w_;
    h = h_;
    
    PolygonShape sd = new PolygonShape();
    float anchoBox2D = box2d.scalarPixelsToWorld(w_/2);
    float altoBox2D = box2d.scalarPixelsToWorld(h_/2); 
    sd.setAsBox(anchoBox2D,altoBox2D);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.1;
    fd.restitution = 0.5;
  
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC; 
    Vec2 pos = new Vec2(x_,y_);
    bd.position.set(box2d.coordPixelsToWorld(pos));
    
    b = box2d.createBody(bd);
    b.createFixture(fd);
    //b.setLinearVelocity(new Vec2(random(-5,5),random(-5,5)));
    //b.setAngularVelocity(random(-10,10));
  }
  
  void aplicarFuerza(Vec2 f){
    Vec2 pos = b.getWorldCenter();
    b.applyForce(f, pos);
  }
  
  
  void moverseA(float x_, float y_, float d_){
    Vec2 pr = box2d.coordPixelsToWorld(x_,y_);
    Vec2 pos = b.getWorldCenter();
    Vec2 f = pr.sub(pos);
    f.normalize();
    f.mulLocal(d_);
    b.applyForce(f,pos);
  }
  
  void nodos(ArrayList <Nodo> nodos_){
    for(Nodo n:nodos_){
      Vec2 pos = box2d.getBodyPixelCoord(b);
      float dist = dist(pos.x, pos.y, n.pos.x,n.pos.y);
      if(dist < n.r){
        float inten = map(dist,0,n.r,1,0);
        moverseA(n.pos.x,n.pos.y,inten*n.f);
      }
    }
  }
  
  
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(b);

    float a = b.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    rectMode(CENTER);
    fill(255,0,0);
    noStroke();
    rect(0,0,w,h);
    popMatrix();
  }
}


class Nodo {
  PVector pos;
  float r;
  float f;
  
  Nodo(){
    pos = new PVector(random(width),random(height));
    r = random(60,200);
    f = random(10,50);
    if(random(1)<0.5){
      f*=-1;
    }
  }
  
  void display(){
    noStroke();
    fill(0,0,255,100);
    circle(pos.x,pos.y,r*2);
  }
}



class Limite{
  float x,y,w,h;
  Body b;
  
  Limite(float x_, float y_,float w_, float h_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    PolygonShape sd = new PolygonShape();
    float anchoBox2D = box2d.scalarPixelsToWorld(w_/2);
    float altoBox2D = box2d.scalarPixelsToWorld(h_/2); 
    sd.setAsBox(anchoBox2D,altoBox2D);
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
     Vec2 pos = new Vec2(x_,y_);
    bd.position.set(box2d.coordPixelsToWorld(pos));
    b = box2d.createBody(bd);
    b.createFixture(sd,1);
  }
  
  void display(){
    fill(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
}
