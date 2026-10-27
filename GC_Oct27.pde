class Chipote{
  PVector pos;
  float tam;
  float inten;
  float dir;
  
  Chipote(){
    pos = PVector.random3D().mult(279);
    tam = random(100,200);
    inten = random(-0.5,0.5);
    dir = random(-0.1,0.1);
  }
  
  void rotar(){
    pos.rotate(dir);
  }
}


PShape mono;
PShape ico;
ArrayList <Chipote> chipotes;

void setup(){
  size(900,900,P3D);
  mono = loadShape("mono.obj");
  mono.disableStyle();
  ico = loadShape("ico.obj");
  chipotes = new ArrayList <Chipote> ();
  for(int i = 0; i<20; i++){
  chipotes.add(new Chipote());
  }
  
}


void draw(){
  background(0);
  lights();
  pushMatrix();
  translate(width/2,height/2);
 
  rotateX(mouseX*0.01);
  rotateY(mouseY*0.01);
  noStroke();
  fill(255,0,0);
  for(Chipote c:chipotes){
    c.rotar();
  }
  
  for(int i = 0; i<ico.getChildCount();i++){
    PShape p= ico.getChild(i);  
    beginShape();
    for(int j = 0 ; j<p.getVertexCount();j++){
      PVector pv = p.getVertex(j).mult(3);
      float escala = 1;
      for(Chipote c: chipotes){
        float dist = pv.dist(c.pos);
        if(dist<c.tam){
          float nivel = map(dist,0,c.tam,1,0);
          nivel*=c.inten;
          escala+=nivel;
        }       
      }
      pv.mult(escala);
      println(pv.mag());
      vertex(pv.x,pv.y,pv.z);
    }
    endShape();
    
  }
  
  
  popMatrix();
  
  //pushMatrix();
  //translate(width/2,height/2);
  
  //rotateX(mouseX*0.01);
  //rotateY(mouseY*0.01);
  
  //for(int i = 0; i<mono.getChildCount();i++){
  //  PShape p= mono.getChild(i);
  //  noStroke();
  //  fill(random(255),random(255),random(255));
  //  beginShape();
  //  for(int j = 0 ; j<p.getVertexCount();j++){
  //    PVector pv = p.getVertex(j).mult(200);
      
  //    vertex(pv.x,pv.y,pv.z);
  //  }
  //  endShape();
    
  //}
  //popMatrix();
}
