import processing.sound.*;

// constants
final float RAIN_MAX = 0.3;
final float RAIN_MIN = 0.005;
final float RAIN_DELTA = 0.001;

SoundFile rainSound;
float rainAmp = 0.01;

SoundFile[] mainSounds;
float mainAmp = 0.3;
String[] songPaths = {"sounds/ichigo_parfum.wav", "sounds/heavens_gate.wav"};
int currentSong = 1;

void setup() {
    size(512, 512);    // for debugging
    // fullScreen();   // for prod
    rainSound = new SoundFile(this, "sounds/rain.wav");
    rainSound.amp(rainAmp);
    rainSound.loop();

    mainSounds = new SoundFile[songPaths.length];
    for (int i = 0; i < songPaths.length; i++) {
        mainSounds[i] = new SoundFile(this, songPaths[i]);
    }
}

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

void draw() {
    if (!mainSounds[currentSong].isPlaying()) {
        playNextSong();
    }
}

void keyPressed() {
    // up = 38, down = 40
    if (keyCode == 38) {
        adjustRainVolume(RAIN_DELTA);
    } else if (keyCode == 40) {
        adjustRainVolume(-RAIN_DELTA);
    }
}

// TODO: lever -> disable/enable sounds
// TODO: button -> play thunders (randomized filter values)
// TODO: joystick -> adjust rain volume