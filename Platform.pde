int platformCount = 10; // 10
int[] platformX = new int[platformCount];
int[] platformY = new int[platformCount];
int platformWidth = 80;
int platformHeight = 10;

class Platform {
   float x, y; // Platform's position
 int width, height; // Platform's dimensions

  void display() {
    fill(0); // Draw the platform as a rectangle
    rect(this.x, this.y, this.width, this.height);
 }
}
