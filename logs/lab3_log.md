# Lab3 Log

Materials:
- joystick
- switch
- button
- button cap (blue)
- 3 resistors
- bread board
- bunch of wires


Resources: 
- Rasp Pi to bread board: https://pinout.xyz/
- Omron Button Datasheet: https://omronfs.omron.com/en_US/ecb/products/pdf/en-b3f.pdf
- https://projects.raspberrypi.org/en/projects/physical-computing/1
- https://gpiozero.readthedocs.io/en/stable/api_input.html



Process Outline
- Found a resource to connect Raspberry Pi to bread board
- Start off simple, let’s just get a program working to print text to screen after button is pressed
- Once this is done, we’ll have a working proof-of-concept of interfacing with the electrical components from the Pi


Actual process:
- Found manual for Omron button
- Found manual to connect button and matched our wires to the photo
- Created a Python file to test button (it worked!)
- Trying different commands to change states

Circuit:
GPIO on X,Y,Button for joystick
5v to 5v, Gnd to Gnd for joystick
4 to GPIO, 2 to GND for button


Troubleshooting:
-We keep forgetting to re-connect the ground when testing and spend 5 minutes trying to figure out why our code isn’t working
