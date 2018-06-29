import ddf.minim.*;
Minim minim;
AudioPlayer bgm;
AudioSnippet sound01;
AudioSnippet sound02;

int phase = 0; //management by phase

ReversiMap reversiMap;
PlayerAI playerAI;
Menu menu;

int p2count = 0;
int count;

int turn = 1;
int fin = 0;

void setup() {
  size(800, 600);
  menu = new Menu();
  reversiMap = new ReversiMap();
  playerAI = new PlayerAI();

  minim = new Minim(this);
  bgm = minim.loadFile("data/bgm.mp3");
  sound01 = minim.loadFile("data/sound01.mp3");
  sound02 = minim.loadFile("data/sound02.mp3");
}

void draw() {
  background(255);
  if (phase == 0) {
    count++;
    menu.display();
  } else if (phase == 1) {
    menu.display();
    fill(0, count);
    count+=3;
    rect(0, 0, 800, 600);
    if (count >= 255) {
      bgm.loop();
      phase = 2;
      count = 0;
    }
  } else if (phase == 2) {
    count++;
    reversiMap.display();
    if (reversiMap.mapChecker(count)==0) {
      fin++;
      turn = -turn;
      if (fin>=2) {
        phase = 3;
      }
    } else {
      fin = 0;
    }

    if (turn == -1) {
      p2count++;
      if (p2count>=70) {
        playerAI.thinking();
        sound02.rewind();
        sound02.play();
        turn = 1;
        p2count = 0;
        count = 0;
      }
    }
  } else if (phase == 3) {
    reversiMap.display();
    fill(255);
    text("please push any key", 270, 300);
  }
}

void stop() {
  bgm.close();
  sound01.close();
  sound02.close();
  minim.stop();
  super.stop();
}

void mousePressed() {
  if (phase == 0) {
    count = 0;
    reversiMap.reset();
    phase = 1;
    sound01.rewind();
    sound01.play();
  } else if (phase == 2&&turn == 1) {
    if (reversiMap.setMap(mouseX, mouseY, turn)==1) {
      sound02.rewind();
      sound02.play();
      turn = -turn;
      count = 0;
    }
  }
}

void keyPressed() {
  bgm.rewind();
  phase = 2;
  reversiMap.reset();
}

