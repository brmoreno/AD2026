FloatList inicio;
FloatList ancho;
FloatList amp;


void setup(){
  size(1200,500);
  inicio = new FloatList();
  ancho  = new FloatList();
  amp = new FloatList();
  
  inicio.append(500);
  ancho.append(300);
  amp.append(-150);
  for(int i = 0; i<30; i++){
    inicio.append(random(width));
    ancho.append(random(200,500));
    amp.append(random(10,50));
    if(random(1)<0.5){
      amp.mult(i,-1);
    }
  }
  float altura  = 1;
  for(int j = 0; j<width; j++){
    altura = 1;
    for(int i = 0; i<inicio.size();i++){
      if(j>inicio.get(i) && j<inicio.get(i)+ancho.get(i)){
        altura+= sin(map(j,inicio.get(i),inicio.get(i)+ancho.get(i),0,PI))*amp.get(i);
      }
    }
    float x = j;
    
    rect(x,height/2,1,altura);
  }
}
