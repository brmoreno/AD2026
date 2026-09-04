float v = 0.005;

void setup(){
  size(900,900);
  for(int i = 0; i<width; i++){
    for(int j = 0; j<height; j++){
      noStroke();
      float noise = noise(i*v,j*v);
      int v = floor(noise*50);
      if(v%2==0){
        fill(0);
      }
      else{
        fill(255);
      }
      rect(i,j,1,1);
    }
  }
}
