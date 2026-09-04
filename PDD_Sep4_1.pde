class Thomas {
  float b = 0.19;
  float x = 0.1;
  float y = 0;
  float z = 0;
  float dt = 0.05;
  ArrayList <PVector> pvs;
  int n;
  float minX=100, minY=100, maxX=-100,maxY=-100;
  float ancho,alto;
  

  Thomas (int n_) {
    n = n_;
    pvs = new ArrayList <PVector>();
    for (int i = 0; i<n; i ++) {
      update();
    }
  
   for(int i = 0; i<n; i++){
     PVector p = pvs.get(i);
     if(p.x>maxX){
       maxX = p.x;
     }
     if(p.y>maxY){
       maxY = p.y;
     }
     
     if(p.x<minX){
       minX = p.x;
     }
     if(p.y<minY){
       minY = p.y;
     }     
   }
    
    ancho = maxX-minX;
    alto = maxY-minY;
    
    println("ancho:"+ ancho + "  alto:"+alto);
  }
  
  Thomas (int n_, float b_) {
    n = n_;
    b = b_;
    pvs = new ArrayList <PVector>();
    for (int i = 0; i<n; i ++) {
      update();
    }
  
   for(int i = 0; i<n; i++){
     PVector p = pvs.get(i);
     if(p.x>maxX){
       maxX = p.x;
     }
     if(p.y>maxY){
       maxY = p.y;
     }
     
     if(p.x<minX){
       minX = p.x;
     }
     if(p.y<minY){
       minY = p.y;
     }     
   }
    
    ancho = maxX-minX;
    alto = maxY-minY;
    
    println("ancho:"+ ancho + "  alto:"+alto);
  }
  
  
  void update() {
    PVector k1 = thomasDeriv(x, y, z);
    PVector k2 = thomasDeriv(x + k1.x*dt/2, y + k1.y*dt/2, z + k1.z*dt/2);
    PVector k3 = thomasDeriv(x + k2.x*dt/2, y + k2.y*dt/2, z + k2.z*dt/2);
    PVector k4 = thomasDeriv(x + k3.x*dt, y + k3.y*dt, z + k3.z*dt);

    x += (dt/6.0) * (k1.x + 2*k2.x + 2*k3.x + k4.x);
    y += (dt/6.0) * (k1.y + 2*k2.y + 2*k3.y + k4.y);
    z += (dt/6.0) * (k1.z + 2*k2.z + 2*k3.z + k4.z);
    pvs.add(new PVector(x, y, z));
  }

  PVector thomasDeriv(float x, float y, float z) {
    float dx = sin(y) - b * x;
    float dy = sin(z) - b * y;
    float dz = sin(x) - b * z;
    return new PVector(dx, dy, dz);
  }
}


Thomas uno;
Thomas dos;
Thomas rojo;
Thomas verde;
Thomas azul;
void setup(){
  size(900,900);
  uno = new Thomas(20000,.19);
  dos = new Thomas(20000, .21);
  rojo = new Thomas(20000,.10);
  verde = new Thomas(20000,.15);
  azul = new Thomas(20000,.25);
  PVector pRef = new PVector(300,0);
  
  
  for(int i = 0; i<uno.n; i++){
    uno.pvs.get(i).mult(30);
    uno.pvs.get(i).rotate(TWO_PI/20000);
    pRef.rotate(TWO_PI/20000);
    uno.pvs.get(i).add(pRef);
  }
  
  translate(width/2,height/2);
  background(255);
  
  for(int i = 0; i<uno.pvs.size();i++){
    PVector a = uno.pvs.get(i);
    PVector b = dos.pvs.get(i);
    noStroke();
    float r = ((rojo.pvs.get(i).heading()+PI)/TWO_PI)*255;
    float g = ((verde.pvs.get(i).heading()+PI)/TWO_PI)*255;
    float bb = ((azul.pvs.get(i).heading()+PI)/TWO_PI)*255;
    fill(r,g,bb,20);
    circle(a.x,a.y,b.x*20);
    
  }

  
  stroke(0);
  noFill();
  beginShape();
   for(PVector p: uno.pvs){
     vertex(p.x,p.y);
   }
  endShape();
}


//float b = 0.19;
//float x = 0.1;
//float y = 0;
//float z = 0;

//float dt = 0.05;
//float zoom = 50;

//void setup() {
//  size(900, 900, P3D);
//}

//void draw() {
//  translate(width/2, height/2, 0);


//  strokeWeight(2);

//    PVector k1 = thomasDeriv(x, y, z);
//    PVector k2 = thomasDeriv(x + k1.x*dt/2, y + k1.y*dt/2, z + k1.z*dt/2);
//    PVector k3 = thomasDeriv(x + k2.x*dt/2, y + k2.y*dt/2, z + k2.z*dt/2);
//    PVector k4 = thomasDeriv(x + k3.x*dt, y + k3.y*dt, z + k3.z*dt);

//    x += (dt/6.0) * (k1.x + 2*k2.x + 2*k3.x + k4.x);
//    y += (dt/6.0) * (k1.y + 2*k2.y + 2*k3.y + k4.y);
//    z += (dt/6.0) * (k1.z + 2*k2.z + 2*k3.z + k4.z);

//    stroke(0);
//    point(x * zoom, y * zoom, z * zoom);

//}

//PVector thomasDeriv(float x, float y, float z) {
//  float dx = sin(y) - b * x;
//  float dy = sin(z) - b * y;
//  float dz = sin(x) - b * z;
//  return new PVector(dx, dy, dz);
//}
