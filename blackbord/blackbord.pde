PImage offscr;

void setup(){
  size(1000, 750);
  background(#2a2a2a);
  strokeWeight(1);
  offscr = createImage(width, height, RGB);
  noLoop();
}
void draw(){
    // 座標の数
    short point_num = 11;
    // 描画座標用配列
    float pointArrayup[][] = new float[point_num][2];
    float pointArraydw[][] = new float[point_num][2];

    // 描画座標の確定
    for(int i=0; i<point_num; i++){
        pointArrayup[i][0] = random(width);
        pointArraydw[i][1] = random(-width);
        pointArrayup[i][1] = random(height/2);
        pointArraydw[i][1] = random(-height/2);
        make_line(pointArrayup[i][0], pointArrayup[i][1], 0);
        make_line(pointArraydw[i][0], pointArraydw[i][1], 1);
    
        loadPixels();
        offscr.pixels = pixels;
        offscr.updatePixels();
        tint(255, 240);
        image(offscr, -3, -3, width + 6, height + 6);
    }
}
void make_line(float x, float y, int point){
    float flag;
    float x1 = x;
    float x2;
    float y1 = y;
    float y2;

    stroke(#fffef6);
    noFill();
    flag = random(1, 100);
    if (flag > 49) {
        flag = 1;
    }
    else{
        flag = -1;
    }

    x2 = x1 + random(-360, 360)*flag;
    y2 = y1 + random(-height, height)*flag;

    line(x1, y1, x2, y2);
    
    switch (point) {
        case 0:
          elps(x1, y1);
          break;
        case 1:
          elps(x2, y2);
          break;
    }
}

void elps(float x, float y){
    float flag;
    float disp = random(2, 6);
    float w = width/16;
    float h = height/18;
    
    flag = random(1, 100);
    if (flag > 49) {
        flag = 1;
    }
    else{
        flag = 1;
    }
    
    stroke(#fffef6);
    noFill();
    for (int i = 0; i < int(disp); i++) {
        x += random(0.2, 2)*flag;
        y += random(0.2, 2)*(-flag);
        w += random(0.4, 40)*flag;
        h += random(-9, 10)*(flag);
        ellipse(x, y, w, h);

    }

}
