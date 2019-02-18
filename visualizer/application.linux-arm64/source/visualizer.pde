import processing.net.*;

Server tcpServer;
Client client;

int segmentSize = 10;
int waveform = 1;
float randomMagnitude = 30;

void setup() {
  size(900, 900);
  tcpServer = new Server(this, 3443);
  client = new Client(this, "127.0.0.1", 3445);
}

void draw() {
  background(0);

  // Update data from Pd.
  if (tcpServer != null) {
    Client c = tcpServer.available();

    while (c != null && c.available() > 0) {
      String[] numbers = c.readString().split("\n");
      String lastNumber = numbers[numbers.length - 1].replace(";", "").trim();

      if (lastNumber.equals("w1")) {
        waveform = 1;
      } else if (lastNumber.equals("w2")) {
        waveform = 2;
      } else if (lastNumber.equals("w3")) {
        waveform = 3;
      } else if (lastNumber.equals("w4")) {
        waveform = 4;
      } else {
        int number = Integer.parseInt(lastNumber);
        randomMagnitude = number;
      }
    }
  }

  // Draw top/bottom random bands.
  if (randomMagnitude > 200) {
    int numBands = 2;
    int topBandFreq = 10;
    int bottomBandFreq = 12;

    for (int i = 0; i < numBands; i++) {
      if (frameCount % topBandFreq == 0) {
        float col = random(100) + 155;
        float y = random(100);
        fill(col);
        rect(0, y, width, y / 20);
      }
    }

    for (int i = 0; i < numBands; i++) {
      if (frameCount % bottomBandFreq == 0) {
        float col = random(100) + 155;
        float y = random(100);
        fill(col);
        rect(0, height - y, width, y / 20);
      }
    }
  }

  // Draw mod depth visualization.
  for (int i = 0; i < width; i += segmentSize) {
    float midY = height / 2;
    float randOffset = random(randomMagnitude);
    float drawY = midY + randOffset - (randomMagnitude * 0.5);

    if (waveform == 1) {
      stroke(random(255));
    } else if (waveform == 2) {
      stroke(random(255), 0, 0);
    } else if (waveform == 3) {
      stroke(0, random(255), 0);
    } else if (waveform == 4) {
      float r = random(255);
      stroke(0, r, r);
    }

    line(i, drawY, i + segmentSize, drawY);
  }
}
