// Kamya Clinton 

// Sound
import ddf.minim.*;
Minim minim;
AudioPlayer bgMusic;

// Images
PImage bgImage;
PImage playerImage;
PImage endImage;
PImage startImage;

// Start Game
boolean isGameStarted = false;
int score = 0;

void setup() {
  size(400, 600);

  playerImage = loadImage("Jerry-PhotoRoom.png");
  playerImage.resize(50, 50);

  bgImage = loadImage ("Tom Angry.jpg");
  bgImage.resize(400, 600);

  endImage = loadImage ("Tom Jerry.jpg");
  endImage.resize(400, 600);

  startImage = loadImage ("Tom-Jerry.png");
  startImage.resize(400, 600);

  // Initialize Minim Sound
  minim = new Minim(this);

  // Load the background sound
  bgMusic = minim.loadFile("Tom and Jerry Tales.mp3");
  bgMusic.loop();

  // Initialize platforms
  for (int i = 0; i < platformCount; i++) {
    platformX[i] = int(random(width - platformWidth));
    platformY[i] = int(random(height / platformCount * i, height / platformCount * (i + 1)));
  }

  // Initialize player on a platform
 int randomPlatform = int(random(platformCount));
 playerX = platformX[randomPlatform] + platformWidth / 2;
 playerY = platformY[randomPlatform] - 15;

    bgMusic.play();
    bgMusic.loop();
  }

void draw() {
  if (!isGameStarted) {
    background(startImage);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Press 'S' to Start", 200, 500);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Jumping Jerry", 200, 100);
  } else {
    background(bgImage);

    // Draw player
    image(playerImage, playerX, playerY);

    // Draw platforms
    fill(252, 199, 3);
    for (int i = 0; i < platformCount; i++) {
      rect(platformX[i], platformY[i], platformWidth, platformHeight);
    }

    // Moves player
    playerX += playerSpeedX;
    playerY += playerSpeedY;
    playerSpeedY += 0.4; // Gravity

    // Check for collision with platforms
    for (int i = 0; i < platformCount; i++) {
      if (playerX + 15 > platformX[i] && playerX - 15 < platformX[i] + platformWidth &&
        playerY + 15 > platformY[i] && playerY - 15 < platformY[i] + platformHeight) {
        playerSpeedY = 0;
        playerY = platformY[i] - 15;
        score++;
        canJump = true; // This resets canJump when player lands on a platform
      }
    }

    // Draw score
    fill(0);
    text("Score: " + score, 50, 20);

    // Move platforms down
    for (int i = 0; i < platformCount; i++) {
      platformY[i] += 5;

      // Check if platform is below the screen, then reset its position
      if (platformY[i] > height) {
        platformY[i] = int(random(-height / 2, -height / 4));
        platformX[i] = int(random(width - platformWidth));
      }
    }

    // Game over if player falls off the screen
    if (playerY > height) {
      gameOver();
    }
  }
}

void keyPressed() {
  if (!isGameStarted && keyCode == 'S') {
    isGameStarted = true;
  } else if (isGameStarted) {
    if (keyCode == LEFT) {
      playerSpeedX = -5; // Moves left
    } else if (keyCode == RIGHT) {
      playerSpeedX = 5; // Moves right
    } else if (keyCode == UP) {
      if (canJump) { // Only allow jumping if canJump is true
        playerSpeedY = -10; // Jump
        canJump = false; // Sets canJump to false to prevent double jumping
      }
    }
  } 
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    playerSpeedX = 0; // Stops horizontal movements when key is released
  }
}

void gameOver() {
  background(endImage);
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over\nScore:" + score, 120, 500);
  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Press 'R' to Replay", 120, 550);
  
  // See's if 'R' key is pressed to restart the game
  if (keyCode == 'R') {
    isGameStarted = true;
    score = 0;

    // Resets player position
    playerX = width / 2;
    playerY = height / 2;

    // Resets player speed
    playerSpeedX = 0;
    playerSpeedY = 0;

    // Resets platforms
    for (int i = 0; i < platformCount; i++) {
      platformX[i] = int(random(width - platformWidth));
      platformY[i] = int(random(height / platformCount * i, height / platformCount * (i + 1)));
    }
  }
}
