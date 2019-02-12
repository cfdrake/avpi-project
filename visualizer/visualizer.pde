int segmentSize = 10;
float randomMagnitude = 30;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  // Draw middle energy band.
  for (int i = 0; i < width; i += segmentSize) {
    float midY = height / 2;
    float randOffset = random(randomMagnitude);
    float drawY = midY + randOffset - (randomMagnitude * 0.5);
    
    stroke(random(255));
    line(i, drawY, i + segmentSize, drawY);
  }
}

void keyPressed() {
  if (keyCode == UP) {
    randomMagnitude += 5;
  } else if (keyCode == DOWN) {
    randomMagnitude -= 5;
  }
  
  randomMagnitude = max(0, min(randomMagnitude, 200));
  
  if (keyCode == RIGHT) {
    segmentSize += 5;
  } else if (keyCode == LEFT) {
    segmentSize -= 5;
  }
  
  segmentSize = max(5, min(segmentSize, 50));
}
