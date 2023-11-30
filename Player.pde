  int playerX, playerY;
  float playerSpeedX = 0;
  float playerSpeedY = 0;
  boolean canJump = true;
  
  class Player {
    PImage image;
    float x, y; // Player's position
    float speedX, speedY; // Player's movement speed
    boolean canJump; // Indicates whether the player can jump
  
    void update() {
      // Move player horizontally
      this.x += this.speedX;
  
      // Apply gravity and apply vertical movement
      this.speedY += 0.4;
      this.y += this.speedY;
  
      // Check if the player is on the ground
      if (this.y >= height) {
        this.y = height;
        this.speedY = 0;
        this.canJump = true;
      }
    }
  
    void jump() {
      if (this.canJump) {
        this.speedY = -10; // Jump upwards
        this.canJump = false; // Disable jumping until the player lands
      }
    }
  
    void display() {
       image(playerImage,playerX, playerY); // Draw the players 
  }
}
