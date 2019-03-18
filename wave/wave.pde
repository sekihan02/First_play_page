float speedOfWaves=1.2;
int periodOfgenerator=40;
boolean move=true;
 
class circle_wave {//a circle with an increasing radius
  float centX;
  float centY;//the center of the wave
 
  float v;//the speed of the waves
  float r;//the distance the wave has traveled
  color c;//the color reprasents weather it's a top or buttom
 
 
  circle_wave(float tempV, float tempCentX, float tempCentY, color tempC) {
    centX = tempCentX;
    centY = tempCentY;
    v = tempV;
    r = 0;
    c = tempC;
  }
 
  void beWave(float wind) {
    r+=v;
    stroke(c,map(r,0,width/2,255,0));
    noFill();
 
    centX-=wind;
 
    ellipse(centX, centY, r*2, r*2);
  }
}
 
class toneGenerator {
  float x;
  float y;//the position of the generator
 
 
  float xV;//the x velocity
 
  int T;//the period of the generator
  int cycles;
 
  ArrayList<circle_wave> waves;//an arraylist of the waves emitted
 
  toneGenerator(float tempXV, float tempX, float tempY, int tempT) {
    T=tempT;
    x=tempX;
    y=tempY;
    xV=tempXV;
 
    waves = new ArrayList<circle_wave>();
    waves.add(new circle_wave(2, x, y, color(255, 255, 255, 100)));
  }
 
  void drawPolygon(int x, int y, int r, int vertexNum) {
    pushMatrix();
    translate(x, y);
    beginShape();
    for (int i = 0; i < vertexNum; i++) {
      vertex(r*cos(radians(360*i/vertexNum)), r*sin(radians(360*i/vertexNum)));
    }
    endShape(CLOSE);
    popMatrix();
  } 

  void generate() {
    fill(0);//display and move the generator
    ellipse(x, y, 10, 10);

    noFill();
    strokeWeight(2);
    stroke(0, 123, 73);
    int tar_x = int(x)+200;
    int tar_y = int(y)-150;
    // drawPolygon(int(random(250,270)), int(random(50,100)), 15, 6);
    drawPolygon(tar_x, tar_y, 15, 6);
    
    int tar2_x = int(x)-60;
    int tar2_y = int(y)-90;
    drawPolygon(tar2_x, tar2_y, 15, 6);
    
    int tar3_x = int(x)+90;
    int tar3_y = int(y)+150;
    drawPolygon(tar3_x, tar3_y, 15, 6);
    
    if (move) {
      x+=xV;
    }
    else {
      for (int i = 0; i<waves.size (); i++) {
        circle_wave myWave = waves.get(i);
        myWave.centX-=xV;
      }

    }
 
      if (x > width) {
        x=0;

      } else if (x < 0) {
        x=width;
      }
      
      //display and move the existing waves
      for (int i = waves.size ()-1; i>=0; i--) {
        circle_wave myWave = waves.get(i);

        if (!move) {
          myWave.beWave(xV);
        }
        else {
          myWave.beWave(0);
        }
 
        if (myWave.r > width/2) {
          waves.remove(i);
        }
      }
 
      if (mousePressed) {
        waves = new ArrayList<circle_wave>();
        waves.add(new circle_wave(2, x, y, color(255, 255, 255, 100)));
  }
 
      if (cycles%(T*2)==0) {
        waves.add(new circle_wave(speedOfWaves, x, y, color(1, 0, 102)));

        
        if (cycles%int(T*0.4)==0) {
          waves.add(new circle_wave(0.25, tar3_x, tar3_y, color(0, 123, 73)));
        }
        
      } else if (cycles%(T*2)==T) {
        waves.add(new circle_wave(speedOfWaves, x, y, color(128, 0, 0)));
        
        waves.add(new circle_wave(0.3, tar2_x, tar2_y, color(0, 123, 73)));
        //waves.add(new circle_wave(speedOfWaves, x, y, color(0, 123, 73)));
      }
      
      if (cycles%(T*2*2)==0) {
                       // target
        waves.add(new circle_wave(0.2, tar_x, tar_y, color(0, 123, 73)));
      }
 
      cycles++;
    }
  }
 
  toneGenerator tone;
 
 
  void setup() {
    size(1000, 750);
    tone = new toneGenerator(0, width/2+20, height/2, periodOfgenerator);
  }
 
  void draw() {
    background(255, 204, 0);
    tone.generate();
  }
 
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        tone.xV-=0.25;
      } else if (keyCode == RIGHT) {
        tone.xV+=0.25;
      }
    } else if (key == ' ') {
      move=!move;
    }
  }
