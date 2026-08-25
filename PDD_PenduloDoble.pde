float r1 = 150, r2 = 150;
float m1 = 20, m2 = 20;
float a1, a2;
float a1_v = 0, a2_v = 0;

PVector origin;
ArrayList<PVector> trail = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  origin = new PVector(width/2, height/2 - 100);
  a1 = PI/2 + 0.5;
  a2 = PI/2;
}

void draw() {
  background(0, 40); 

  float g = 1;

  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2 * a2);
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2);
  float den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  float a1_a = (num1 + num2 + num3 * num4) / den;

  num1 = 2 * sin(a1 - a2);
  num2 = (a1_v * a1_v * r1 * (m1 + m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v * a2_v * r2 * m2 * cos(a1 - a2);
  den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  float a2_a = (num1 * (num2 + num3 + num4)) / den;

  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  a1_v *= 0.999;
  a2_v *= 0.999;

  float x1 = origin.x + r1 * sin(a1);
  float y1 = origin.y + r1 * cos(a1);
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  trail.add(new PVector(x2, y2));
  if (trail.size() > 500) trail.remove(0);

  noFill();
  stroke(255, 100);
  beginShape();
  for (PVector p : trail) vertex(p.x, p.y);
  endShape();

  stroke(255);
  strokeWeight(2);
  line(origin.x, origin.y, x1, y1);
  line(x1, y1, x2, y2);

  fill(255);
  noStroke();
  circle(origin.x, origin.y, 6);
  circle(x1, y1, m1);
  circle(x2, y2, m2);
}
