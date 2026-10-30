ArrayList <PVector> lineaInicial;
ArrayList <PVector> ref;
ArrayList <PVector> puntos;
int numeroCaras;

boolean dibujando = true;
void setup(){
  size(900,900,P3D);
  lineaInicial = new ArrayList <PVector> ();
  
}

void draw(){
  if(dibujando){
    background(255);
    stroke(255,0,0);
    line(width/2,0,width/2,height);
    stroke(0);
    noFill();
    beginShape();
    for(PVector p:lineaInicial){
      vertex(p.x,p.y);
    }
    endShape();
  }
  else{
    background(0);
    lights();
    pushMatrix();
    translate(width/2, height/2);
    rotateX(mouseX*0.01);
    rotateY(mouseY*0.01);
    fill(255);
    noStroke();
    for(int i = 0; i<puntos.size();i++){
      int costilla = i/ref.size();
      int pos = i%ref.size();
      if(pos< ref.size()-1 && costilla <numeroCaras-1){
        PVector a = puntos.get(i);
        PVector b = puntos.get(i+ref.size());
        PVector c = puntos.get(i+ref.size()+1);
        PVector d = puntos.get(i+1);
        beginShape();
        vertex(a.x,a.y,a.z);
        vertex(b.x,b.y,b.z);
        vertex(c.x,c.y,c.z);
        vertex(d.x,d.y,d.z);
        endShape();
      }      
      if(pos< ref.size()-1 && costilla == numeroCaras-1){
        PVector a = puntos.get(i);
        PVector b = puntos.get(pos);
        PVector c = puntos.get(pos+1);
        PVector d = puntos.get(i+1);
        beginShape();
        vertex(a.x,a.y,a.z);
        vertex(b.x,b.y,b.z);
        vertex(c.x,c.y,c.z);
        vertex(d.x,d.y,d.z);
        endShape();
      }
    }
    popMatrix();
    
  }
}

void mousePressed(){
  lineaInicial.add(new PVector(mouseX,mouseY));
}

void keyPressed(){
  ref = new ArrayList <PVector> ();
  puntos = new ArrayList <PVector>();
  dibujando = false;
  for(PVector p: lineaInicial){
    p.sub(width/2,height/2);
    ref.add(new PVector(p.x,0,p.y));
  }
  numeroCaras = 6;
  for(int i = 0; i<numeroCaras;i++){
    for(PVector p: ref){
      p.rotate(TWO_PI/numeroCaras);
      puntos.add(p.copy());
    }
  }
  
  
}
