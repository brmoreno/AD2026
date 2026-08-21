class Poligono{  
  float x,y;
  float t;
  int n;
  color c;
  float r;
  float dr;
  
  Poligono(float x_, float y_, float t_, int n_){
    x = x_;
    y = y_;
    t = t_;
    n = n_;
    c = color(random(255),random(255),random(255));
    r = random(TWO_PI);
    dr = random(-0.01,0.01);
  }
  
  void display(){
    fill(c);
    noStroke();
    beginShape();
    r+=dr;
    for(int i = 0; i<n; i++){
      float angulo = (TWO_PI/n)*i;
      float vx = x+cos(angulo+r)*t;
      float vy = y + sin(angulo+r)*t;
      vertex(vx,vy);
    }
    endShape();
    
  } 
}


class Capa{
  int n;
  Poligono p;
  float r;
  float dr;
  int blend;
  
  Capa(float x_, float y_, float t_, int n_, int n2_){
    p = new Poligono(x_,y_,t_,n_);
    n = n2_;
    dr = random(-0.01,0.01);
    r = random(TWO_PI);
    blend = floor(random(0.6,3));
  }
  
  
  void display(){
    switch(blend){
      case 0:
        blendMode(BLEND);
      break;
      case 1:
        blendMode(ADD);
      break;
      case 2:
        blendMode(SUBTRACT);
      break;
    }
    r+=dr;
    pushMatrix();
    translate(width/2, height/2);
    rotate(r);
    for(int i = 0; i<n; i++){
      rotate(TWO_PI/n);
      p.display();
    }
    popMatrix();
  }
}


ArrayList <Capa> capas;

void setup(){  
  size(900,900);
  capas = new ArrayList <Capa> ();
  for(int i = 0; i<10; i++){
    capas.add(new Capa(random(400),random(400),random(50,300),round(random(3,8)),round(random(3,8))));
  }
  
 

}


void draw(){
  background(0);
  for(Capa c:capas){
    c.display();
  }
}
