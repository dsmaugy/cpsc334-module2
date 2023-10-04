# Lab 4 Log

## Arduino IDE Setup
- Things were smooth overall for Siri except for her USB converter made running Arduino examples on the ESP32 unreliable. 
- Darwin had a broken pip but fixed it by using `pyenv` to re-install Python11 in a virtual environment.
- To get the arduino IDE to detect pyserial, Darwin had to launch the IDE from terminal which had the pyenv-python environment set up with pyserial installed

## User Groups
On personal laptop, Darwin is using Arch linux and needed to add himself to uucp group instead of “dialout”

## ESP32 Issues
- Siri's serial monitor was not being updated in calls to `loop()`
- Darwin's ESP32 was failing to display joystick values from `analogRead()`
    - Initially, Serial.println of the analogRead would print out text from different parts of the program text segment/debug logs
    - Other analog input pins were not working
    - Switching to a new ESP32 seems to have fixed the problem
