import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList <Box> boxes;
Limite l;


void setup(){
  size(900,900);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boxes = new ArrayList <Box> ();
  box2d.setGravity(0,-10);
  l = new Limite(width/2,height-30,width,30);
}


void draw(){
  box2d.step();
  background(255);
  if(mousePressed){
    boxes.add(new Box(mouseX,mouseY,random(30,50),random(30,50)));
  }
  for(Box b:boxes){
    b.display();
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
    b.setLinearVelocity(new Vec2(random(-5,5),random(-5,5)));
    b.setAngularVelocity(random(-10,10));
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
