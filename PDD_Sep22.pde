void setup(){
  size(900,900);
  background(255);
  fill(0);
  
  for(float i = 0; i<TWO_PI; i+= 0.01 ){
    float x =  width/2 + cos(i)*(300+100*sin(i*8));
    float y = height/2 +sin(i)*(300+100*sin(i*7));
    
    circle(x,y,10);
  }
}
