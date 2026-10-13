PVector esquinas[] = new PVector[8];
PVector ePro[] = new PVector[8];
float w = 100;
float eyeZ;
float angulo = PI/6;


void setup(){
  size(800,600);
  esquinas[0] = new PVector(-w,-w,-w);
  esquinas[1] = new PVector(w,-w,-w);
  esquinas[2] = new PVector(w,w,-w);
  esquinas[3] = new PVector(-w,w,-w);
  esquinas[4] = new PVector(-w,-w,w);
  esquinas[5] = new PVector(w,-w,w);
  esquinas[6] = new PVector(w,w,w);
  esquinas[7] = new PVector(-w,w,w);
  
}


void draw(){
  eyeZ = (height/2.0)/tan(angulo);
  
  background(0);
  PVector mouse = new PVector(0,mouseY,mouseX);
  for(int i = 0; i<8;i++){
    esquinas[i].rotate(0.05);
    PVector pos = proyectar(esquinas[i].copy().add(mouse));
    ePro[i] = pos.copy();
    noStroke();
    fill(255);
    circle(pos.x,pos.y,5);
  } 
  
  stroke(255);
  arista(ePro[0],ePro[1]);
  arista(ePro[1],ePro[2]);
  arista(ePro[2],ePro[3]);
  arista(ePro[3],ePro[0]);
  
  arista(ePro[4],ePro[5]);
  arista(ePro[5],ePro[6]);
  arista(ePro[6],ePro[7]);
  arista(ePro[7],ePro[4]);

  arista(ePro[0],ePro[4]);
  arista(ePro[1],ePro[5]);
  arista(ePro[2],ePro[6]);
  arista(ePro[3],ePro[7]);
}



PVector proyectar(PVector pv_){
  float escala = eyeZ/(eyeZ-pv_.x);
  float vx = width/2 +(pv_.z - width/2)*escala;
  float vy = height/2 + (pv_.y -height/2)*escala;
  PVector resultado = new PVector(vx, vy);
  return resultado;
}

void arista(PVector a_, PVector b_){
  line(a_.x,a_.y,b_.x,b_.y);
}

void keyPressed(){
  if(key == 'z'){
    angulo -= 0.1;
  }
  
  if(key == 'x'){
    angulo += 0.1;
  }
}
