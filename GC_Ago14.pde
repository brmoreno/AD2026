float [] v = {200,200,300,300,200,200,800,800,100,100,400,100,400,400};

float x,y,t,dx,dy;
color c;


void setup(){
  size(1000,1000);
  x = width/2;
  y = height/2;
  t = 200;
  colorMode(RGB,255);
  blendMode(BLEND);
  dx = 3;
  dy = 3.5;
  c = color(random(255),random(255),random(255));
}

void draw(){
  background(#C6446D);
colorMode(HSB,100);
blendMode(MULTIPLY);
fill(25,100,100);
stroke(0,0,255);

rect(v[0],v[1],400,300);
fill(75,100,100);
rect(v[2],v[3],400,300);

colorMode(RGB,255);
blendMode(BLEND);
stroke(255);
strokeWeight(30);
line(v[4],v[5],v[6],v[7]);

noStroke();
fill(240,100,250);
beginShape();
vertex(v[8],v[9]);
vertex(v[10],v[11]);
vertex(v[12],v[13]);
endShape();

for(int i = 0; i<v.length;i++){
  v[i] += random(-10,10);
}

fill(c);
blendMode(ADD);
circle(x,y,t);
x+= dx;
y+= dy;

if(x>width){
  dx*=-1;
}
if(x<0){
  dx*=-1;
}


if(y>height){
  dy*=-1;
}
if(y<0){
  dy*=-1;
}
}


