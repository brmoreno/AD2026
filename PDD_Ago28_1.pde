size(900,900);
noiseSeed(1);
noiseDetail(8);

for(int i = 0; i<width; i+=10){
  for(int j = 0; j<height; j+= 10){
    fill(noise(i*0.005,j*0.005)*255);
    noStroke();
    rect(i,j,10,10);
  }
}
