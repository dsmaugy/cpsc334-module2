# rainplayer

Created by: Darwin Do

# Overview

Rainplayer is a system that explores the heightened sensations that a rainstorm can provide while listening to calming music. One of my core memories as a kid is staying cool and cozy in my childhood bedroom on hot stormy summer days with the rain splattering outside my bedroom window. This system tries to capture some of that magic by playing rain sounds over a series of calming tracks and allowing the player to control the intensity of the storm.

The system uses a joystick to control the amplitude of the rain, a STSP switch to control whether the system is on or not, and a push button that plays a random thunder sound. All peripherals are connected to the ESP32 which in turn is connected to a Raspberry Pi. The visuals and audio are controlled by a Processing program running on the Pi and messages from the ESP32 are sent to the Pi via USB-serial communication.

# Demo

To demonstrate the system, I connected the Raspberry Pi to a desktop monitor and an old cassette player that can also play Line In from a 3.5mm jack.

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled.png)

[https://www.youtube.com/watch?v=_TbbDGC6yNM](https://www.youtube.com/watch?v=_TbbDGC6yNM)

*NOTE: halfway through the demo, the rechargeable lamp I was using runs out of power. This is unrelated to the demo.

# Enclosure

My enclosure is built from cardboard scraps obtained in the scrap bin at the School of Architecture. The foundation of the enclosure is a 10”x10” square piece of cardboard with 2.5” high walls. Holes were cut on the sides to expose the I/O ports on the Pi and a wall was set up to keep the Pi from sliding around. Gorilla Glue was used to connect the pieces together.

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%201.png)

Holes were cut on the ceiling piece to make room for the peripherals. Masking tape was used to secure the joystick and switch in place. Support structures were made to prop the ceiling piece up and provide a foundation for the push button to “sit” on so that it can be reliably pressed. 

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%202.png)

Tape was used to create a hinge on the ceiling piece.

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%203.png)

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%204.png)

# Wiring

To ensure the buttons would function consistently, I soldered two wires to the button prongs and attached the other ends to jumper cables with electrical tape binding them so they don’t fall out.

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%205.png)

![Untitled](rainplayer%206b5416a51b154fe4acc2fe2afe61205c/Untitled%206.png)

# Sound - Auditory Component

While the demo video showcases just one backing track (Ichigo Aoba’s *Parfum d'étoiles*), there are a series of 3 different songs that can be toggled through:

[Parfum d'étoiles](https://www.youtube.com/watch?v=Dp48g6Fdn-c) - Ichigo Aoba

[Subwoofer Lullaby](https://www.youtube.com/watch?v=Gpd85y_iTxY) - C418

[Heaven’s Gate](https://www.youtube.com/watch?v=6TOJPYdmmpQ) - Oh, Yoko

The rain sound loop comes from an audio recording on [freesound.org](https://freesound.org/people/inuetc/sounds/507902/).

The series of thunder sounds used comes from the following resources:

- [https://www.youtube.com/watch?v=xK_m77VZYnc](https://www.youtube.com/watch?v=xK_m77VZYnc)
- [https://freesound.org/people/FlatHill/sounds/237729/](https://freesound.org/people/FlatHill/sounds/237729/)
- [https://freesound.org/people/RHumphries/sounds/2523/](https://freesound.org/people/RHumphries/sounds/2523/)

Every time the thunder button is activated, a random thunder sample is chosen with random parameters on a reverb filter and low-pass filter to create variation.

# Dot Movement - Visual Component

The visual component of this system consists of a series of dots that move on screen following randomly generated Bezier curves. The velocity of each dot on the curve is dependent on the current amplitude of the backing track. When the dot reaches the end of its Bezier curve, a new Bezier curve is generated starting at the current location of the dot. This creates the effect of the dots “jumping” around to the rhythm of the slow ambient tracks.

When the rain is louder, the dots are more constrained in their movement and clump up in the middle. When the rain is softer, the constraints are loosened and their curves are allowed to extend further out towards the borders of the screen. The number of dots is dependent on the screen size.

Since my demo video doesn’t show the visuals super clearly, I re-recorded the program on my desktop and let all three songs play. I did not adjust the rain volume or thunder at all during this recording.

[https://www.youtube.com/watch?v=LdFgIT9qOJU](https://www.youtube.com/watch?v=LdFgIT9qOJU)

# Issues

I ran into some issues with the ESP32s and reading analog values. For some reason, if I tried to print concatenated strings defined with double quotes and readings from the `analogRead` function, I would get garbage in my Serial monitor:

```arduino
// this prints out garbage!!
Serial.println("VRX: " + analogRead(VRX_PIN));
```

But if I used the `String` class, then everything magically works.

```arduino
// this works!!?
Serial.println(String("VRX: ") + analogRead(VRX_PIN));
```

I’m still not sure why this is. 

# Code

[GitHub - dsmaugy/cpsc334-module2: Interactive Systems](https://github.com/dsmaugy/cpsc334-module2/tree/master)