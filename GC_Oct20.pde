void setup(){
  size(900,900,P3D);
  uno = new Cubo();
  cubos = new ArrayList <Cubo>();
  for(int i = 0; i<400; i++){
    cubos.add(new Cubo());
  }
}
class Cubo{
  float t;
  color c;
  float vx;
  float vy;
  float vz;
  float dx;
  float dy;
  float dz;
  float amp;
  float rx;
  float ry;
  float drx;
  float dry;
  
  
  Cubo(){
    t = random(30,60);
    c= color(random(255),random(255),random(255));
    vx = random(TWO_PI);
    vy = random(TWO_PI);
    vz = random(TWO_PI);
    dx = random(-0.05,0.05);
    dy = random(-0.05,0.05);
    dz = random(-0.05,0.05);
    amp = random(100,300);
    rx = random(TWO_PI);
    drx = random(-0.1,0.1); 
    ry = random(TWO_PI);
    dry = random(-0.1,0.1); 
  }
  
  void display(){
    pushMatrix();
    translate(sin(vx)*amp,sin(vy)*amp,sin(vz)*amp);
    rotateX(rx);
    rotateY(ry);
    fill(c);
    box(t);
    popMatrix();
    vx+=dx;
    vy+= dy;
    vz+= dz;
    rx+=drx;
    ry+=dry;
  }
 
  
  
}



Cubo uno;
ArrayList <Cubo> cubos;
void draw(){  
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2);
  rotateX(mouseX*0.01);
  rotateY(mouseY*0.01);
  noStroke();
  fill(255);
  box(200);
  for(Cubo c:cubos){
    c.display();
  }
  uno.display();
  popMatrix();
}
