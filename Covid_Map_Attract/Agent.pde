class Agent{
  PVector pos;
  float r;
  float mass;
  PImage img;
  String str;
  
  Agent(float r, PImage img, String str){
    //pos = new PVector(random(0, width), random(0, height));
    pos = PVector.random2D().mult(width/2);
    this.r = r;
    mass = PI*r*r*density;
    this.img = img;
    this.str = str;
  }
  
  void attract(ArrayList<Agent> others){
    PVector center = new PVector(0, 0);
    PVector dpc = PVector.sub(center, this.pos);
    float dstC = dpc.mag();
    this.pos.add(dpc.mult(mass/(1000+dstC)));
    for(Agent agent : others){
      if(agent != this){
        PVector dp = PVector.sub(agent.pos, this.pos);
        float dst = dp.mag();
        float goalDst = (this.r + agent.r)*1.2;
        if(dst < goalDst){
          PVector targetPos = PVector.add(this.pos, dp.setMag(goalDst));
          agent.pos = PVector.lerp(targetPos, agent.pos, 0.8);
        }
      }
    }
  }
  
  void show(){
    image(img, pos.x-r, pos.y-r, r*2, r*2);
    textSize(r/2);
    textAlign(CENTER, CENTER);
    text(str, pos.x, pos.y);
  }
}
