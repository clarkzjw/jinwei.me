ArrayList particles;
int maxParticles = 255;

void setup() {
  size(window.innerWidth, window.innerHeight);
  particles = new ArrayList();
  rectMode(CENTER);
}

void draw() {
  background(21, 32, 46);

  if(particles.size() < maxParticles) {
    x = random(0, width);
    y = random(0, height);
    PVector l = new PVector(x, y);
    Particle particle = new Particle(l);
    particles.add(particle);
  }


  for(int i=0; i<particles.size(); i++) {
    Particle p = (Particle) particles.get(i);
    Particle next;

    if(i>1) {
      next = (Particle) particles.get(i-1);
      stroke(57,219,255,10);
      line(next.location.x, next.location.x, p.location.x, p.location.y)
    }


    // Run the particle
    p.run();

    if(p.isDead()) {
      particles.remove(i);
    }
  }
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float   lifespan;
  float   rectSize;

  Particle(PVector l) {
    location = l.get();
    velocity = new PVector(random(0,0.05),random(0.02, 0.8));
    acceleration = new PVector(random(0, 0.01),random(0,0.01));
    lifespan = 255.0;
    rectSize = 5;
  }

  void run() {
    display();
    update();
  }

  void display() {
    noStroke();
    fill(73, 219, 255, lifespan/5);
    rect(location.x, location.y, rectSize, rectSize);
  }

  void update() {
    lifespan -= 2;
    velocity.add(acceleration);
    location.add(velocity);
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}
