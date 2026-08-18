int o []= new int [16];

void setup(){
  
  for(int i = 0; i<16; i++){
    o[i] = floor(random(4));
  }
size(900,900);
background(255);
fill(0);
noStroke();
  for(int i = 0; i<20; i++){
    for(int j =  0; j<20; j++){
      float x = i*45;
      float y = j*45;
      int vx = i%4;
      int vy = j%4;
      int v = vy*4 +vx;
      mosaico(x,y,45,o[v]);
    }  
  }
}


void mosaico(float x_, float y_, float t_, int v_){
  fill(0);
  switch(v_){
    case 0:
      triangle(x_,y_,x_+t_,y_,x_,y_+t_);
    break;
    case 1:
      triangle(x_,y_,x_+t_,y_,x_+t_,y_+t_);
    break;
    case 2:
      triangle(x_,y_,x_+t_,y_+t_,x_,y_+t_);
    break;
    default:
    triangle(x_+t_,y_,x_+t_,y_+t_,x_,y_+t_);
    break;
  }
  noFill();
  stroke(127);
  rect(x_,y_,t_,t_);
}
