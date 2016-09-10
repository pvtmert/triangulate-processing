//import android.view.KeyEvent;
/* @pjs preload="data/1.png,data/1.jpg,data/2.png,data/2.jpg,data/3.png,data/3.jpg,data/4.png,data/4.jpg,data/5.png,data/5.jpg,data/6.png,data/6.jpg"; */
/* @pjs crisp="true"; pauseOnBlur="true"; */

PImage img[];
PGraphics pg;
final int last_image = 6;
final String base = "";
final boolean is_android = true;

int ci = 0;
void mouseClicked() {
    ci += 1;
    dist = 0;
    if(ci > last_image)
    	ci = 1;
    img = new PImage[] {
        loadImage(base+ci+".jpg"),
        loadImage(base+ci+".png"),
    };
    for(int i=0;i<2;i++) {
    	//println(img[i].width + " " + img[i].height);
    	img[i].resize((int)(img[i].width * 1.5), (int)(img[i].height * 1.5));
    }
    /*
    double ratio = (double)img[0].width/(double)img[0].height;
    int nwidth, nheight, diffs[] = { abs(width-img[0].width), abs(height-img[0].height) };
    */
    /*
    for(int i=0;i<img[1].pixels.length;i++)
    	img[1].pixels[i] &= 0x00ffffff;
    img[1].updatePixels();
    */
    if(is_android) return;
    pg = createGraphics(img[1].width,img[1].height);
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
    img[1].mask(pg);
    return;
}

void keyPressed() {
    if(key == CODED)
    	//if(keyCode == android.view.KeyEvent.KEYCODE_BACK)
    		mouseClicked();
    keyCode = 0;
    return;
}

void setup() {
    orientation(LANDSCAPE);
    //size(displayWidth,displayHeight);
    fullScreen();
//    surface.setResizable(true);
    fill(255);
    textSize(36);
    imageMode(CENTER);
    blendMode(BLEND);
    mouseClicked();
    return;
}

int pos[]={0,0}, dist=0;
void draw() {
    background(0);
    if(is_android) tint(255,255);
    image(img[0],width/2,height/2/*,width,height*/);
    if(is_android) tint(255,map(dist,0,max(width,height),0,min(width,height)));
    image(img[1],width/2,height/2/*,width,height*/);
    fill(255);
    textAlign(CENTER,CENTER);
    if(dist == 0)
        text("swipe to triangulate,\nhold back to change\n",width/2,height-height/4);
    textAlign(LEFT,TOP);
    text("> "+frameRate,11,11);
    return;
}

void mousePressed() {
    pos[0] = mouseX;
    pos[1] = mouseY;
    return;
}

void mouseDragged() {
    dist = (int)( pow(mouseX-pos[0],2) + pow(mouseY-pos[1],2) );
    dist = (int)sqrt(abs(dist));
    if(is_android) return;
    pg.beginDraw();
    pg.noStroke();
    pg.ellipseMode(CENTER);
    int ox = (img[1].width - width)/2;
    int oy = (img[1].height - height)/2;
    float rad = min(img[1].width,img[1].height)/8.0;
    /*
    pg.noFill();
    for (int i = 1; i<66; i++) {
        pg.stroke(0,0,255, 255-(255*i/66));
        pg.ellipse(mouseX+ox, mouseY+oy, rad+i, rad+i);
    }
    */
    pg.fill(0,0,200);
    pg.ellipse(mouseX+ox,mouseY+oy,rad,rad);
    pg.endDraw();
    img[1].mask(pg);
    img[1].updatePixels();
    return;
}