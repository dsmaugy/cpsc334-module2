from gpiozero import GPIODevice
from time import sleep

yDir = GPIODevice(14)
xDir = GPIODevice(15)
button = GPIODevice(18)

while True:
    print(f"xDir: {xDir.value}")
    print(f"yDir: {yDir.value}")
    print(f"Button: {button.value}")
    sleep(0.1)
