class ReversiMap {
  int reversiMode [][] = new int [8][8];
  int reverserCount [] = new int [9];
  int movieCount [][] = new int [8][8];
  int movieMode [][] = new int [8][8];
  ReversiMap() {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        reversiMode [i][j] = 0;
        movieCount [i][j] = 0;
        movieMode [i][j] = 0;
      }
    }
    for (int i=0; i<9; i++) {
      reverserCount [i] = 0;
    }
  }
  void display() {
    int p1=0;
    int p2=0;
    background(0, 155, 0);
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        stroke(0);
        strokeWeight(1);
        fill(0, 125, 0);
        rect(i*75, j*75, 75, 75);
        noStroke();
        fill(0, 155, 0);
        rect(4+i*75, 4+j*75, 69, 69);
        fill(0, 170, 0);
        rect(8+i*75, 8+j*75, 65, 65);
        if (reversiMode[i][j] != 0) {
          if (reversiMode[i][j] == 1) {
            fill(0);
            stroke(0);
            ellipse(37+i*75, 37+j*75, 60, 60);
            fill(20);
            noStroke();
            ellipse(37+i*75, 37+j*75, 52, 52);
            fill(40);
            ellipse(37+i*75, 37+j*75, 34, 34);
            fill(255);
            p1++;
          } else {
            fill(215);
            stroke(0);
            ellipse(37+i*75, 37+j*75, 60, 60);
            fill(235);
            noStroke();
            ellipse(37+i*75, 37+j*75, 52, 52);
            fill(255);
            ellipse(37+i*75, 37+j*75, 34, 34);
            p2++;
          }
        }
      }
    }

    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (movieCount[i][j]>0) {
          movie(i, j, movieCount[i][j], movieMode[i][j]);
          movieCount[i][j]--;
        }
      }
    }

    textSize(20);
    noStroke();
    if (turn == 1) {
      fill(0);
      text("player1's turn", 620, 200);
      ellipse(630, 250, 20, 20);
    } else {
      fill(255);
      text("player2's turn", 620, 200);
      ellipse(630, 250, 20, 20);
    }

    fill(0);
    text("p1: " + p1 + "     p2: " + p2, 630, 400);
  }
  void reset() {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        reversiMode [i][j] = 0;
      }
    }
    reversiMode[3][3] = 1;
    reversiMode[3][4] = -1;
    reversiMode[4][3] = -1;
    reversiMode[4][4] = 1;
    turn = 1;
  }

  void movie(int x, int y, int count, int mode) {
    if (mode==0) {
      if (count<20) {
        noFill();
        strokeWeight(1);
        for (int i=0; i<50; i++) {
          stroke(255, 255, 0, 5*i);
          ellipse(37+x*75, 37+y*75, 100-count*count/4+i, 100-count*count/4+i);
        }
      }
    } else if (mode==1) {
      if (count<20) {
        noFill();
        strokeWeight(1);
        for (int i=0; i<30; i++) {
          stroke(255, 0, 0, 5*i);
          ellipse(37+x*75, 37+y*75, 100-count*count/4+i, 100-count*count/4+i);
        }
      }
    }
  }


  int setMap(int x, int y, int t) {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (x>i*75&&x<(i+1)*75&&y>j*75&&y<(j+1)*75) {
          if (reversiMode[i][j] == 0) {
            if (setCheck(i, j, 0) == 1) {
              reversiMode[i][j] = t;
              movieCount[i][j] = 20;
              movieMode[i][j] = 0;
              return 1;
            }
          }
        }
      }
    }
    return 0;
  }
  int setCheck(int x, int y, int m) {
    int checkDir = 0;
    int checkNum = 0;
    int checkFlag [] = new int [9];
    //check around stone
    for (int i=-1; i<=1; i++) {
      for (int j=-1; j<=1; j++) {
        //check enemy stone
        if (x+i>-1&&x+i<8&&y+j>-1&&y+j<8) {
          if (reversiMode[x+i][y+j]==-turn) {
            //serch player stone
            for (int k=2; k<8; k++) {
              if (x+i*k>-1&&x+i*k<8&&y+j*k>-1&&y+j*k<8) {
                if (reversiMode[x+i*k][y+j*k]==0&&checkFlag[checkDir]==0) {
                  k=8;
                } else if (reversiMode[x+i*k][y+j*k]==turn&&checkFlag[checkDir]==0) {
                  reverserCount[checkDir] = k-1;
                  checkFlag[checkDir] = 1;
                }
              }
            }
            //serch player stone(end)
          }
        }
        //check enemy stone(end)
        checkDir++;
      }
    }
    //check around stone(end)

    for (int i=0; i<9; i++) {
      if (checkFlag[i] == 1) {
        if (m==0) {
          reverser(x, y);
        } else {
        }
        for (int j=0; j<9; j++) {
          reverserCount[j] = 0;
        }
        return 1;
      }
    }
    return 0;
  }
  void reverser(int x, int y) {
    if (reverserCount[0]>0) {
      for (int i=1; i<=reverserCount[0]; i++) {
        reversiMode[x-i][y-i] = turn;
        movieMode[x-i][y-i] = 1;
        movieCount[x-i][y-i] = 20;
      }
    }
    if (reverserCount[1]>0) {
      for (int i=1; i<=reverserCount[1]; i++) {
        reversiMode[x-i][y] = turn;
        movieMode[x-i][y] = 1;
        movieCount[x-i][y] = 20;
      }
    }
    if (reverserCount[2]>0) {
      for (int i=1; i<=reverserCount[2]; i++) {
        reversiMode[x-i][y+i] = turn;
        movieMode[x-i][y+i] = 1;
        movieCount[x-i][y+i] = 20;
      }
    }
    if (reverserCount[3]>0) {
      for (int i=1; i<=reverserCount[3]; i++) {
        reversiMode[x][y-i] = turn;
        movieMode[x][y-i] = 1;
        movieCount[x][y-i] = 20;
      }
    }
    if (reverserCount[5]>0) {
      for (int i=1; i<=reverserCount[5]; i++) {
        reversiMode[x][y+i] = turn;
        movieMode[x][y+i] = 1;
        movieCount[x][y+i] = 20;
      }
    }
    if (reverserCount[6]>0) {
      for (int i=1; i<=reverserCount[6]; i++) {
        reversiMode[x+i][y-i] = turn;
        movieMode[x+i][y-i] = 1;
        movieCount[x+i][y-i] = 20;
      }
    }
    if (reverserCount[7]>0) {
      for (int i=1; i<=reverserCount[7]; i++) {
        reversiMode[x+i][y] = turn;
        movieMode[x+i][y] = 1;
        movieCount[x+i][y] = 20;
      }
    }
    if (reverserCount[8]>0) {
      for (int i=1; i<=reverserCount[8]; i++) {
        reversiMode[x+i][y+i] = turn;
        movieMode[x+i][y+i] = 1;
        movieCount[x+i][y+i] = 20;
      }
    }
  }
  int mapChecker(int count) {
    int checker = 0;
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (reversiMode[i][j]==0) {
          if (setCheck(i, j, 1) == 1) {
            checker++;
            if (count>360) {
              stroke(0);
              fill(255, 255, 0, 225-cos(radians(count*PI))*225);
              rect(i*75, j*75, 75, 75);
              noStroke();
              fill(0, 155, 0, 225-cos(radians(count*PI))*225);
              rect(10+i*75, 10+j*75, 55, 55);
              fill(0, 155, 0, 225-cos(radians(count*PI))*225);
              rect(20+i*75, 20+j*75, 35, 35);
            }
          }
        }
      }
    }
    if (checker == 0) {
      return 0;
    } else {
      return 1;
    }
  }
}

