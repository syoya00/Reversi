class PlayerAI {
  int x;
  int y;
  int f;
  int level;
  int cheat;
  PlayerAI() {
    x=0;
    y=0;
    f=0;
    level=2;
    cheat=0;
  }
  void thinking() {
    //xとyに設置する座標を直接入れる

    for (int c=0; c>-1; c++) {

      if (level == 1) {
        x = 37+int(random(8))*75;
        y = 37+int(random(8))*75;
      } else if (level == 2) {

        //角をとる
        if (reversiMap.setCheck(0, 0, 1)==1&&reversiMap.reversiMode[0][0]==0) {
          x = 37;
          y = 37;
        } else if (reversiMap.setCheck(0, 7, 1)==1&&reversiMap.reversiMode[0][7]==0) {
          x = 37;
          y = 37+7*75;
        } else if (reversiMap.setCheck(7, 0, 1)==1&&reversiMap.reversiMode[7][0]==0) {
          x = 37+7*75;
          y = 37;
        } else if (reversiMap.setCheck(7, 7, 1)==1&&reversiMap.reversiMode[7][7]==0) {
          x = 37+7*75;
          y = 37+7*75;
        }

        //角をとれない場合
        if (c>100) {
          //適当な箇所に置く
          for (int i=0; i<8; i++) {
            for (int j=0; j<8; j++) {
              if (reversiMap.reversiMode[i][j]==0&&reversiMap.setCheck(i, j, 1)==1) {
                x = 37+i*75;
                y = 37+j*75;
              }
            }
          }
        } else if (c>40) {
          //a~h、3~6におく
          x = 187+int(random(4))*75;
          y = 37+int(random(8))*75;
        } else if (c>20) {
          //c~f, 1~8におく
          x = 37+int(random(8))*75;
          y = 187+int(random(4))*75;
        }
      }else if(level==3){
        int rNum = 64;
        int setX;
        int setY;

        for(int i=0;i<8;i++){
          for(int j=0;j<8;j++){
            if(reversiMap.reversiMode[i][j]==0&&reversiMap.setCheck(i,j,1)==1){
              
              setX = 37+i*75;
              setY = 37+j*75;
            }
          }
        }
      }

      //x,yが何もない場所ならばc=-10にしてループをぬける
      if (reversiMap.setMap(x, y, turn)==1) {
        //チート, 適当な箇所を無理矢理ひっくりかえす
        if (cheat == 1) {
          int did = 0;
          for (int k=0; k<8; k++) {
            for (int l=0; l<8; l++) {
              if (reversiMap.reversiMode[k][l] == -turn&&did ==0) {
                reversiMap.reversiMode[k][l] = turn;
                did = 1;
              }
            }
          }
        }
        c = -10;
      }
    }
  }
}

