ArrayList <PVector> puntos;
ArrayList <Triangulo> triangulos;

class Triangulo {
  PVector a, b, c, centro;
  float radio;

  Triangulo(PVector a, PVector b, PVector c) {
    this.a = a;
    this.b = b;
    this.c = c;
    double bx = b.x-a.x;
    double by = b.y-a.y;
    double cx = c.x-a.x;
    double cy = c.y-a.y;
    double d = 2*(bx*cy - by*cx);
    double b2 = bx*bx + by*by;
    double c2 = cx*cx + cy*cy;
    double ux = (cy*b2 - by*c2)/d;
    double uy = (bx*c2 - cx*b2)/d;
    centro = new PVector(a.x+(float)ux, a.y+(float)uy);
    radio = (float)Math.sqrt(ux*ux + uy*uy);
  }

  boolean usa(PVector p) {
    return a == p || b == p || c == p;
  }
}

void setup() {
  size(900, 900);
  puntos = new ArrayList <PVector> ();
  for (int i = 0; i < 60; i++) {
    puntos.add(new PVector(random(50, width-50), random(50, height-50)));
  }
  triangulos = delaunay(puntos);
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(1);
  noFill();
  for (Triangulo t : triangulos) {
    triangle(t.a.x, t.a.y, t.b.x, t.b.y, t.c.x, t.c.y);
  }
  strokeWeight(5);
  for (PVector p : puntos) {
    point(p.x, p.y);
  }
}



ArrayList <Triangulo> delaunay(ArrayList <PVector> puntos) {
  ArrayList <Triangulo> tri = new ArrayList <Triangulo> ();
  if (puntos.size() < 3) {
    return tri;
  }

  float minX = puntos.get(0).x;
  float minY = puntos.get(0).y;
  float maxX = minX;
  float maxY = minY;
  for (PVector p : puntos) {
    minX = min(minX, p.x);
    minY = min(minY, p.y);
    maxX = max(maxX, p.x);
    maxY = max(maxY, p.y);
  }
  float cx = (minX+maxX)/2;
  float cy = (minY+maxY)/2;
  float r = max(dist(minX, minY, maxX, maxY)/2, 1);
  float d = 2*r*20;
  PVector s0 = new PVector(cx, cy-d);
  PVector s1 = new PVector(cx-d*cos(PI/6), cy+d*sin(PI/6));
  PVector s2 = new PVector(cx+d*cos(PI/6), cy+d*sin(PI/6));
  tri.add(new Triangulo(s0, s1, s2));

  ArrayList <PVector> insertados = new ArrayList <PVector> ();
  for (PVector p : puntos) {
    if (insertados.contains(p)) {
      continue;
    }
    insertados.add(p);

    ArrayList <Triangulo> malos = new ArrayList <Triangulo> ();
    for (Triangulo t : tri) {
      if (PVector.dist(p, t.centro) < t.radio) {
        malos.add(t);
      }
    }

    ArrayList <PVector[]> borde = new ArrayList <PVector[]> ();
    for (Triangulo t : malos) {
      PVector[][] aristas = {{t.a, t.b}, {t.b, t.c}, {t.c, t.a}};
      for (PVector[] e : aristas) {
        boolean compartida = false;
        for (Triangulo otro : malos) {
          if (otro != t && otro.usa(e[0]) && otro.usa(e[1])) {
            compartida = true;
          }
        }
        if (!compartida) {
          borde.add(e);
        }
      }
    }

    tri.removeAll(malos);
    for (PVector[] e : borde) {
      tri.add(new Triangulo(e[0], e[1], p));
    }
  }

  for (int i = tri.size()-1; i >= 0; i--) {
    Triangulo t = tri.get(i);
    if (t.usa(s0) || t.usa(s1) || t.usa(s2)) {
      tri.remove(i);
    }
  }
  return tri;
}
