from gpiozero import GPIODevice, Button
from time import sleep

yDir = GPIODevice(14)
xDir = GPIODevice(15)
button = GPIODevice(18)
blueButton = Button(2)


while True:
    print(f"xDir: {xDir.value}")
    print(f"yDir: {yDir.value}")
    print(f"Joy Button: {button.value}")
    print(F"Blue Button: {blueButton.value}")
    sleep(0.1)
