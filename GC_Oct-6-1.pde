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

class Poligono{
  PVector esquinas [];
  Nodo lado1[];
  Nodo lado2[];
  PVector lado3[];
  PVector lado4[];
  float t;
  ArrayList <PVector> fin;
  
  Poligono(float x_, float y_, float t_, int n_){
    t = t_;
    esquinas = new PVector[4];
    esquinas[0] = new PVector(x_, y_);
    esquinas[1] = new PVector(x_+t_, y_);
    esquinas[2] = new PVector(x_+t_, y_+t_);
    esquinas[3] = new PVector(x_, y_+t_);
    lado1 = new Nodo[n_];
    lado2 = new Nodo[n_];
    lado3 = new PVector[n_];
    lado4 = new PVector[n_];
    float d = t_/(n_+1);
    for(int i = 0; i<n_; i++){
      lado1[i] = new Nodo(x_+d+i*d,y_);
      lado2[i] = new Nodo(x_+t_,y_+d+i*d);
      lado3[i] = new PVector(x_+d+i*d,y_+t_);
      lado4[i] = new PVector(x_,y_+d+i*d);
     }
  }
  
  void display(){
    beginShape();
    vertex(esquinas[0].x,esquinas[0].y);
    for(Nodo n:lado1){
      vertex(n.p.x,n.p.y);
      n.mover();
    }
    vertex(esquinas[1].x,esquinas[1].y);
    for(Nodo n:lado2){
      vertex(n.p.x,n.p.y);
      n.mover();
    }
    
    vertex(esquinas[2].x,esquinas[2].y);
    
    for(int i = lado3.length-1; i>=0; i--){
      vertex(lado3[i].x,lado3[i].y);
    }
    vertex(esquinas[3].x,esquinas[3].y);
    for(int i = lado4.length-1; i>=0; i--){
      vertex(lado4[i].x,lado4[i].y);
    }
    
    
    endShape(CLOSE);
    for(Nodo n:lado1){
      n.display();
    }
    for(Nodo n:lado2){
      n.display();
    }
    
    

  }
  
  void funcion(){
    for(Nodo n: lado1){
      float dist = dist(mouseX,mouseY,n.p.x,n.p.y);
      if(dist<10){
        n.activo = true;
        break;
      }
    }
    for(Nodo n: lado2){
      float dist = dist(mouseX,mouseY,n.p.x,n.p.y);
      if(dist<10){
        n.activo = true;
        break;
      }
    }
  }
  
  void onRelease(){
    for(Nodo n: lado1){
      n.activo = false;
    }
    for(Nodo n: lado2){
      n.activo = false;
    }
    
    for(int i = 0; i<lado1.length;i++){
      lado4[i] = PVector.sub(lado1[i].p,esquinas[0]).rotate(HALF_PI).add(esquinas[0]);
      lado3[i] = PVector.sub(lado2[i].p,esquinas[2]).rotate(-HALF_PI).add(esquinas[2]);
    }
  }
  
  void normalizar(){
    fin = new ArrayList <PVector> ();    
    fin.add(new PVector(esquinas[0].x,esquinas[0].y));
    for(Nodo n:lado1){
      fin.add(new PVector(n.p.x,n.p.y));
    }
    fin.add(new PVector(esquinas[1].x,esquinas[1].y));
    for(Nodo n:lado2){
      fin.add(new PVector(n.p.x,n.p.y));
      n.mover();
    }
    
    fin.add(new PVector(esquinas[2].x,esquinas[2].y));
    
    for(int i = lado3.length-1; i>=0; i--){
      fin.add(new PVector(lado3[i].x,lado3[i].y));
    }
    fin.add(new PVector(esquinas[3].x,esquinas[3].y));
    for(int i = lado4.length-1; i>=0; i--){
      fin.add(new PVector(lado4[i].x,lado4[i].y));
    } 
    
    PVector esq = fin.get(0).copy();    
    for(PVector p: fin){
      p.sub(esq);
    }
  }
  
  void dibujaRota(int v){
  float[] ang = {0, HALF_PI, PI, -HALF_PI};
  float[][] off = {{0,0},{t,0},{t,t},{0,t}};
  pushMatrix();
  translate(off[v][0], off[v][1]);
  rotate(ang[v]);
  beginShape();
  for(PVector p: fin) vertex(p.x, p.y);
  endShape(CLOSE);
  popMatrix();
}

void teselado(){
  int n = int(t);
  for(int i = -n; i < width+n; i += n){
    for(int j = -n; j < height+n; j += n){
      if((i/n + j/n)%2==0){
        fill(255);
      }
      else{
        fill(0);
      }
      int c = Math.floorMod(i/n, 2);
      int r = Math.floorMod(j/n, 2);
      int v = (c==0) ? (r==0 ? 0 : 3) : (r==0 ? 1 : 2);
      pushMatrix();
      translate(i, j);
      dibujaRota(v);
      popMatrix();
    }
  }
}
}

Poligono uno;
boolean tesela = false;
void setup(){
  size(1500,900);
  
  uno = new Poligono(200,200,200,5);
  
}

void draw(){
  background(255);
  if(!tesela){
    fill(255);
    uno.display();
  }
  else{
    uno.teselado();
  }
}

void mousePressed(){
  uno.funcion();
}

void mouseReleased(){
  uno.onRelease();
}

void keyPressed(){
  uno.normalizar();
  tesela = !tesela;
}
