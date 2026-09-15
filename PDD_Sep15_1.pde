PVector deferente;
PVector epi;
PVector epi2;
PGraphics pg;
float dif [] = new float[3];
float x;
void setup(){
  size(900,900);
  deferente = new PVector(200,00);
  epi = new PVector(100,0);
  epi2 = new PVector(60,0);
  pg = createGraphics(width,height);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();
  for(int i = 0; i<3; i++){
    dif[i]= random(-0.05,0.05);
  }
  background(255);
}


void draw(){
  //image(pg,0,0);
  x+=0.5;
  translate(x,height/2);
  stroke(0,120);
  strokeWeight(0.5);
  line(0,0,deferente.x,deferente.y);
  noFill();
  //circle(0,0,deferente.mag()*2);
  //line(-deferente.mag(),0,deferente.mag(),0);
  //line(-deferente.mag(),0,deferente.x,deferente.y);
  //line(deferente.mag(),0,deferente.x,deferente.y);
  line(deferente.x,deferente.y,deferente.x+epi.x,deferente.y+epi.y);
  line(deferente.x+epi.x,deferente.y+epi.y,deferente.x+epi.x+epi2.x,deferente.y+epi.y+epi2.y);
  //circle(deferente.x,deferente.y,epi.mag()*2);
  circle(deferente.x,deferente.y,5);
  //circle(deferente.x+epi.x,deferente.y+epi.y,5);
  deferente.rotate(dif[0]);
  epi.rotate(dif[1]);
  epi2.rotate(dif[2]);
  pg.beginDraw();
  pg.translate(width/2,height/2);
  pg.fill(255,0,0);
  pg.noStroke();
  pg.circle(deferente.x+epi.x+epi2.x,deferente.y+epi.y+epi2.y,5);
  pg.endDraw();
}
