class Poligono{
  ArrayList <PVector> pvs;
  PVector pos;
  float ancho;
  float alto;
  boolean termino = false;
  float rota = 0;
  float scala = 1;
  
  Poligono (){
    pvs = new ArrayList <PVector>();
    pos = new PVector(0,0,0);
  }
  
  void agregarVertice(float x_ ,float y_){
    if(!termino){
      pvs.add(new PVector(x_,y_));
    }
  }
  
  void display(){
    ArrayList <PVector> paraDibujo = new ArrayList <PVector>();
    
    for(PVector p: pvs){
      paraDibujo.add(p.copy());
    }
    
    for(PVector p: paraDibujo){
      //p.rotate(rota);
      //p.mult(scala);
      if(keyPressed){
        if(key == 'h'){
          p.x*=-1;
          p.x+=ancho;
        }
      }
      p.add(pos);
    }
    stroke(0);
    fill(255,0,0);
    beginShape();
    for(PVector p: paraDibujo){
      vertex(p.x,p.y);
    }
    endShape(CLOSE);
  }
  
  void displayIterativo(PVector p_){
    ArrayList <PVector> paraDibujo = new ArrayList <PVector>();    
    for(PVector p: pvs){
      paraDibujo.add(p.copy());
    }   
    for(PVector p: paraDibujo){
      p.add(p_);
    }
    stroke(0);
    fill(255,0,0);
    beginShape();
    for(PVector p: paraDibujo){
      vertex(p.x,p.y);
    }
    endShape(CLOSE);
    
  }
  
  void hop(){
    pos = new PVector(0,0);
    int rep =  floor(width/(ancho*1.1));
    for(int i = 0; i<rep;i++){
      displayIterativo(pos);
      pos.add(ancho*1.1,0);
    }   
  }
  
  void analisis(){
    float minX = 1000;
    float maxX = -1000;
    float minY = 1000;
    float maxY = -1000;
    for(int i = 0; i<pvs.size();i++){
      PVector p = pvs.get(i);
      if(p.x<minX){
        minX =p.x;
      }
      if(p.x>maxX){
        maxX = p.x;
      }
      if(p.y<minY){
        minY =p.y;
      }
      if(p.y>maxY){
        maxY = p.y;
      }
    }
    pos = new PVector(minX,minY);
    ancho = maxX-minX;
    alto = maxY-minY;
    for(int i = 0; i<pvs.size();i++){
      pvs.get(i).sub(pos);
    }
    termino = true;
  }
}

Poligono uno;
int estado = 0;

void setup(){
  size(1500,500);
  uno = new Poligono();
}

void draw(){
  background(255);
  switch(estado){
    case 0:
    uno.display(); 
    break;
    case 1:
    uno.hop();
    break;
  }
  
}

void mousePressed(){
  uno.agregarVertice(mouseX,mouseY);
}

void keyPressed(){
  if(key == 'a'){
  uno.analisis();
  }
  
  if(key == 's'){
  uno.pos = new PVector(mouseX,mouseY);
  }
  
  if(key == 'z'){
    uno.rota+=0.1;
  }
  if(key == 'x'){
    uno.rota-=0.1;
  }
  
  if(key == 'c'){
    uno.scala+=0.1;
  }
  if(key == 'v'){
    uno.scala-=0.1;
  }
  
  if(key == 'q'){
    estado = 1;
  }
  
}
