class funRan{
  float rangoEntrada;
  float rangoSalida;
  float[] valsRef;
  int nPuntos;
  
  funRan(float rE_, float rS_, int nPuntos_){
    rangoEntrada = rE_;
    rangoSalida = rS_;
    nPuntos = nPuntos_;
    valsRef = new float[nPuntos];
    for(int i = 0; i<nPuntos; i++){
      valsRef[i] = random(rangoSalida);
    }
  }
  
  
  float val(int v_){
    float rango = rangoEntrada/nPuntos;
    int anterior = v_/floor(rango);
    int siguiente = anterior + 1;
    float va = valsRef[anterior];
    float vc = valsRef[siguiente];
    float distancia = v_%rango;
    float proporcion = distancia/rango;
    return lerp(va,vc,proporcion);
  }
  
}


funRan rojo;
funRan verde;
funRan azul;
void setup(){
 rojo = new funRan(1200,255,10);
 verde = new funRan(1200,255,10);
  azul = new funRan(1200,255,10);
size(800,400);
color ran [] = new color[5];
for(int i = 0; i<5; i++){
  ran[i] = color(random(255),random(255),random(255));
}
FloatList num = new FloatList();

for(int i = 0; i<400; i++){
  num.append(random(400));
}

rectMode(CENTER);

for(int i = 0; i<800; i++){
  float x = i;
  float y = width/2;
  //float t = num.get(i);
  stroke(random(100,255),random(0,85),random(100,155));
  int v = floor(random(5));
  //stroke(ran[v]);
  stroke(rojo.val(i),verde.val(i),azul.val(i));
  rect(x,y,1,800);
}

saveFrame();
}
