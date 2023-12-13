ArrayList <Bubble> bubbles;
float factor = 0.003;
int total = 0;

void setup() {
  size(500, 900);
  bubbles = new ArrayList <Bubble> ();
}

void draw() {
  total = bubbles.size();
  background(245);
  textSize(20);
  fill(200, 50, 100, 150);
  textAlign(CENTER, TOP);
  text("Total Bubbles = " + total, width/2, 50);
  if (mousePressed) {
    bubbles.add(new Bubble());
  }
  for (int i = 0; i < bubbles.size(); i++) {
    bubbles.get(i).move();
    if (bubbles.get(i).y < 0) {
      bubbles.get(i).y = height;
    } else {
      bubbles.get(i).show();
    }
    collision(bubbles);
  }
}

void collision(ArrayList <Bubble> bubbles_) {
  for (int i = bubbles_.size() - 1; i >= 0; i--) {
    for (int j = bubbles_.size() - 1; j >= 0; j--) {
      if (dist(bubbles_.get(i).x, bubbles_.get(i).y, bubbles_.get(j).x, bubbles_.get(j).y) <= (bubbles_.get(i).sz + bubbles_.get(j).sz)/2.0 && i != j) {
        bubbles_.get(i).pop = true;
        bubbles_.get(j).pop = true;
      }
    }
  }
  for (int i = bubbles_.size() - 1; i >= 0; i--) {
    if (bubbles_.get(i).x + bubbles_.get(i).sz/2.0 > width || bubbles_.get(i).x - bubbles_.get(i).sz/2.0 < 0 || bubbles_.get(i).x == 0 || bubbles_.get(i).x == width) {
      bubbles_.get(i).pop = true;
    }
    if (bubbles_.get(i).pop) {
      bubbles_.remove(i);
    }
  }
}

class Bubble {
  float x, y;
  float r, g, b;
  float sz, sp;
  boolean pop = false;

  Bubble() {
    r = (float)(Math.random() * 255);
    g = (float)(Math.random() * 255);
    b = (float)(Math.random() * 255);
    x = (float)(Math.random() * width);
    y = height + 20;
    sz = (float)(Math.random() * 40) + 15;
    sp = sz * sz * factor;
  }

  void move() {
    x += ((float)(Math.random() * 12) - 6) * sp/5.0;
    y -= sp;
  }

  void show() {
    fill(r, g, b, 150);
    ellipse(x, y, sz, sz);
  }
}
