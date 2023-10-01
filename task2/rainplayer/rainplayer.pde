import processing.sound.*;

// constants
final float RAIN_MAX = 0.3;
final float RAIN_MIN = 0.005;
final float RAIN_DELTA = 0.001;
final int THUNDER_THRESHOLD = 100;
final float THUNDER_MIN = 0.65;
final float THUNDER_MAX = 0.7;

SoundFile rainSound;
float rainAmp = 0.01;

SoundFile[] mainSounds;
float mainAmp = 0.3;
String[] songPaths = {"sounds/ichigo_parfum.wav", "sounds/heavens_gate.wav"};
int currentSong = 1;

SoundFile[] thunderSounds;
String[] thunderPaths = {"sounds/thunder1.wav", "sounds/thunder2.wav", "sounds/thunder3.wav"};
int lastThunderTime = 0;

void adjustRainVolume(float adj) {
    rainAmp = rainAmp + adj <= RAIN_MAX && rainAmp + adj >= RAIN_MIN ? rainAmp + adj : rainAmp;
    rainSound.amp(rainAmp);
}

void playNextSong() {
    if (mainSounds[currentSong].isPlaying()) {
        mainSounds[currentSong].pause();
    }
    currentSong = (currentSong + 1) % songPaths.length;
    mainSounds[currentSong].jump(0);
    mainSounds[currentSong].amp(mainAmp);
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
// TODO: raise volume of thunder
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
    size(512, 512);    // for debugging
    // fullScreen();   // for prod


    mainSounds = new SoundFile[songPaths.length];
    for (int i = 0; i < songPaths.length; i++) {
        mainSounds[i] = new SoundFile(this, songPaths[i]);
    }

    thunderSounds = new SoundFile[thunderPaths.length];
    for (int i = 0; i < thunderPaths.length; i++) {
        thunderSounds[i] = new SoundFile(this, thunderPaths[i]);
    }

    rainSound = new SoundFile(this, "sounds/rain.wav");
    rainSound.amp(rainAmp);
    rainSound.loop();

    currentSong = int(random(0, songPaths.length));
    playNextSong();
}

void draw() {

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

// TODO: lever -> disable/enable sounds
// TODO: button -> play thunders (randomized filter values)
// TODO: joystick -> adjust rain volume