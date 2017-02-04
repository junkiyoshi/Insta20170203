class Particle 
{
  Body body;
  float size;
  float lifespan;
  boolean countDown;
  color bodyColor;

  Particle(float x, float y, float size_, color c) {
    size = size_;
    lifespan = 255;
    countDown = false;
    bodyColor = c;
    makeBody(new Vec2(x, y));
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size);
    cs.setRadius(box2dSize / 2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 0.5;
    fd.friction = 1;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
  
  boolean isDead()
  {
    if(lifespan < 0){
      box2d.destroyBody(body);
      return true;
    }else{
      return false;
    }
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    pushMatrix();
    translate(pos.x, pos.y);
    fill(bodyColor, lifespan);
    noStroke();
    ellipse(0, 0, size, size);
    popMatrix();
    
    if(countDown)
    {
      lifespan -= 20;
    }
  }
}