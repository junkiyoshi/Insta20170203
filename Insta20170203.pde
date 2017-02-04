import java.util.*;
import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Box box;

void setup()
{
  size(512, 512);
  background(255);
  frameRate(30);
  colorMode(HSB);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  
  particles = new ArrayList<Particle>();
  box = new Box();
}

void draw()
{
  background(0);
  box2d.step();
  
  //box.display();
  
  if(frameCount % 5 == 0)
  {
    color c = color(frameCount % 255, 255, 255);
    for(int i = 0; i < 5; i += 1)
    {
      Particle p = new Particle(width / 2 + random(-1, 1), height / 2 + random(-1, 1), 10, c);
      //p.body.setLinearVelocity(new Vec2(x, y));
      particles.add(p);
    }
    
    float x = 30 * cos(radians(frameCount % 360));
    float y = 30 * sin(radians(frameCount % 360));
    box2d.setGravity(x, y);
  }
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.display();
    
    if(p.isDead())
    {
      it.remove();
    }
  }
  
  println(frameCount);
  /*
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  }
  */
}