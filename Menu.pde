class Menu {
  Menu() {
  }
  void display() {
    background(0, 155, 0);
    fill(255, 255, 0);
    textSize(100);
    text("Reversi", 200, 200);
    fill(255, sin(radians(count))*255);
    textSize(20);
    text("click start", 340, 400);
  }
}

