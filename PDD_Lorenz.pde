ArrayList<PVector> points = new ArrayList<PVector>();

float x = 0.1, y = 0, z = 0;
float a = 10, b = 28, c = 8.0/3.0;
float dt = 0.01;
float scale = 8;

float rotX = 0.3;
float rotY = 0.0;
int maxPoints = 10000;

void setup() {
  size(800, 800, P3D);
  background(0);
}

void draw() {
  background(0);

  for (int i = 0; i < 5; i++) {
    float dx = a * (y - x);
    float dy = x * (b - z) - y;
    float dz = x * y - c * z;

    x += dx * dt;
    y += dy * dt;
    z += dz * dt;

    points.add(new PVector(x * scale, y * scale, (z - 27) * scale));
    if (points.size() > maxPoints) points.remove(0);
  }

  translate(width/2, height/2, 0);
  rotateX(rotY); // arrastre vertical rota en X
  rotateY(rotX); // arrastre horizontal rota en Y

  stroke(255, 150);
  strokeWeight(1);
  noFill();

  beginShape(LINES);
  for (int i = 1; i < points.size(); i++) {
    PVector p1 = points.get(i - 1);
    PVector p2 = points.get(i);
    vertex(p1.x, p1.y, p1.z);
    vertex(p2.x, p2.y, p2.z);
  }
  endShape();
}

void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY += (mouseY - pmouseY) * 0.01;
}
