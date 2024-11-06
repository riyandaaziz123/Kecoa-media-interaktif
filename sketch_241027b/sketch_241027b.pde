import java.util.ArrayList;
import processing.sound.*;

ArrayList<Cokroach> coks;
PImage img;
SoundFile soundFX;
SoundFile backgroundMusic;
int lastSpawnTime = 0;
int score = 0; // Variabel untuk menghitung skor

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  img = loadImage("kecoa.png");

  // Muat efek suara dan musik latar
  soundFX = new SoundFile(this, "Headshot.wav");  // Pastikan file sound tersedia
  backgroundMusic = new SoundFile(this, "Masked dededes theme.wav");  // Pastikan file musik latar tersedia

  // Mainkan musik latar secara terus-menerus
  backgroundMusic.loop();
}

void draw() {
  background(255);
  
    fill(0); // Warna teks hitam
    textSize(24); // Ukuran teks
    text("Riyanda Azizi 22.11.4680", 50, 50);  // Tampilkan nama di posisi (50, 50)

  // Menambahkan Cokroach setiap 5 detik di lokasi acak
  if (millis() - lastSpawnTime > 5000) {
    float x = random(width);
    float y = random(height);
    coks.add(new Cokroach(img, x, y));
    lastSpawnTime = millis();
  }

  // Menggambar setiap kecoa
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    c.live();
  }

  // Tampilkan skor di layar
  fill(51);
  textSize(16); 
  text("Score: " + score, 50, 750); 
  text("Cokroaches: " + coks.size(), 50, 780); 
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    for (int i = coks.size() - 1; i >= 0; i--) {
      Cokroach c = coks.get(i);
      if (dist(mouseX, mouseY, c.pos.x, c.pos.y) < img.width / 2) {
        coks.remove(i);  // Menghapus kecoa yang diklik
        score++;  // Menambah skor
        soundFX.play();  // Memainkan efek suara
        break;
      }
    }
  }
}
