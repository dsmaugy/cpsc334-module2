import processing.sound.*;
import processing.serial.*;

// constants
final float RAIN_MAX = 0.3;
final float RAIN_MIN = 0.005;
final float RAIN_DELTA = 0.001;
final int THUNDER_THRESHOLD = 100;
final float THUNDER_MIN = 0.65;
final float THUNDER_MAX = 0.7;
final String ESP32_PORT = "/dev/ttyUSB0";
final float JOY_MIN = 1000;
final float JOY_MAX = 2000;
final float RAIN_UPDATE_THRESH = 50;

SoundFile rainSound;
float rainAmp = 0.01;
float lastRainAmpUpdate = 0;

SoundFile[] mainSounds;
float mainAmp = 0.3;
String[] songPaths = {"sounds/ichigo_parfum.wav", "sounds/heavens_gate.wav", "sounds/subwoofer_lullaby.wav"};
int currentSong = 1;
Amplitude currentSongAmpDetector;

SoundFile[] thunderSounds;
String[] thunderPaths = {"sounds/thunder1.wav", "sounds/thunder2.wav", "sounds/thunder3.wav"};
int lastThunderTime = 0;

BezierNode[] bzNodes;
int numBzNodes;

Serial esp32;


class BezierNode {

    float bzAnchorX1, bzAnchorY1, bzAnchorX2, bzAnchorY2, bzControlX1, bzControlY1, bzControlX2, bzControlY2;
    float curveT;

    public BezierNode () {
        randomizeBezierPoints();

        this.curveT = 0;
    }

    public void advanceNodeOnPath(float delta) {
        this.curveT += delta;

        if (this.curveT < 1) {
            float x = bezierPoint(this.bzAnchorX1, this.bzControlX1, this.bzControlX2, this.bzAnchorX2, this.curveT);
            float y = bezierPoint(this.bzAnchorY1, this.bzControlY1, this.bzControlY2, this.bzAnchorY2, this.curveT);
            ellipse(x, y, 15, 15);
        } else {
            float startX = this.bzAnchorX2;
            float startY = this.bzAnchorY2;
            this.curveT = 0;

            randomizeBezierPoints();
            this.bzAnchorX1 = startX;
            this.bzAnchorY1 = startY;
        }
    }

    private void randomizeBezierPoints() {
        float adjustment = rainAmp * 1.2;
        this.bzAnchorX1 = int(random(width*adjustment, width*(1-adjustment)));
        this.bzAnchorX2 = int(random(width*adjustment, width*(1-adjustment)));
        this.bzControlX1 = int(random(width*adjustment, width*(1-adjustment)));
        this.bzControlX2 = int(random(width*adjustment, width*(1-adjustment)));
        this.bzAnchorY1 = int(random(height*adjustment, height*(1-adjustment)));
        this.bzAnchorY2 = int(random(height*adjustment, height*(1-adjustment)));
        this.bzControlY1 = int(random(height*adjustment, height*(1-adjustment)));
        this.bzControlY2 = int(random(height*adjustment, height*(1-adjustment)));
    }

}


void adjustRainVolume(float adj) {
    if (millis() - lastRainAmpUpdate > RAIN_UPDATE_THRESH) {
        rainAmp = rainAmp + adj <= RAIN_MAX && rainAmp + adj >= RAIN_MIN ? rainAmp + adj : rainAmp;
        rainSound.amp(rainAmp);
        lastRainAmpUpdate = millis();
    }

}

void playNextSong() {
    if (mainSounds[currentSong].isPlaying()) {
        mainSounds[currentSong].pause();
    }
    currentSong = (currentSong + 1) % songPaths.length;
    mainSounds[currentSong].jump(0);
    mainSounds[currentSong].amp(mainAmp);
    currentSongAmpDetector.input(mainSounds[currentSong]);
}

// called every time switch is flipped
void setPlaying(boolean shouldPlay) {
    if (shouldPlay && !rainSound.isPlaying()) {
        rainSound.loop();
        playNextSong();
    } else if (!shouldPlay && rainSound.isPlaying()) {
        rainSound.pause();
        mainSounds[currentSong].pause();
    }
}

// called every time button is pressed
void playThunder() {
    // prevent phantom thunder from button press
    if (millis() - lastThunderTime > THUNDER_THRESHOLD) {
        float thunderAmp = random(THUNDER_MIN + rainAmp, THUNDER_MAX + rainAmp); 
        Reverb thunderReverb = new Reverb(this);
        thunderReverb.set(int(random(0, 1)), int(random(0, 1)), int(random(0, 1)));
        LowPass lpFilter = new LowPass(this);
        lpFilter.freq(random(1000, 5000));

        SoundFile choosenSound = thunderSounds[int(random(0, thunderPaths.length))];
        choosenSound.amp(thunderAmp);
        choosenSound.jump(0);
        thunderReverb.process(choosenSound);
        lpFilter.process(choosenSound);
        lastThunderTime = millis();
    }
}

void setup() {
    // size(512, 512);    // for debugging
    fullScreen();   // for prod
    stroke(102, 106, 134);
    fill(146, 182, 177);

    mainSounds = new SoundFile[songPaths.length];
    for (int i = 0; i < songPaths.length; i++) {
        mainSounds[i] = new SoundFile(this, songPaths[i]);
    }

    thunderSounds = new SoundFile[thunderPaths.length];
    for (int i = 0; i < thunderPaths.length; i++) {
        thunderSounds[i] = new SoundFile(this, thunderPaths[i]);
    }

    numBzNodes = int(sqrt(height*width)/50);
    bzNodes = new BezierNode[numBzNodes];
    for (int i = 0; i < numBzNodes; i++) {
        bzNodes[i] = new BezierNode();
    }

    rainSound = new SoundFile(this, "sounds/rain.wav");
    rainSound.amp(rainAmp);

    currentSongAmpDetector = new Amplitude(this);

    currentSong = 0;

    printArray(Serial.list());
    esp32 = new Serial(this, ESP32_PORT, 115200);
    esp32.bufferUntil('\n');
}


void draw() {
    background(232, 221, 181);

    // node movement speed dependant on background song amplitude
    float currentAmp = currentSongAmpDetector.analyze();
    float bzDelta = mainSounds[currentSong].isPlaying() ? currentAmp/5 : 0;

    for (int i = 0; i < numBzNodes; i++) {
        bzNodes[i].advanceNodeOnPath(bzDelta);
    }
}

// for testing purposes only
void keyPressed() {
    // up = 38, down = 40
    if (keyCode == 38) {
        adjustRainVolume(RAIN_DELTA);
    } else if (keyCode == 40) {
        adjustRainVolume(-RAIN_DELTA);
    } else if (key == 'p') {
        setPlaying(false);
    } else if (key == 'u') {
        setPlaying(true);
    } else if (key == 't') {
        playThunder();
    }
}

void serialEvent(Serial p) { 
    String serialEvent = p.readString(); 
    if (serialEvent.startsWith("VRX:")) {
        int joyVal = int(serialEvent.substring(5).trim());

        if (joyVal <= JOY_MIN) {
            adjustRainVolume(-RAIN_DELTA);
        } else if (joyVal >= JOY_MAX) {
            adjustRainVolume(RAIN_DELTA);
        }
    } else if (serialEvent.startsWith("SWITCH:")) {
        int switchVal = int(serialEvent.substring(8).trim());

        if (switchVal == 0) {
            setPlaying(true);
        } else if (switchVal == 1) {
            setPlaying(false);
        }     
    } else if (serialEvent.startsWith("BUT:")) {
        int buttonVal = int(serialEvent.substring(5).trim());
        
        if (buttonVal == 1) {
            playThunder();
        }
    }
} 

