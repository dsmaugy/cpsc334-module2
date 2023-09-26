from gpiozero import GPIODevice, Button

from time import sleep

# pin definitions
yDir = GPIODevice(14)
xDir = GPIODevice(15)
button = GPIODevice(18)
blueButton = Button(2)

def weather_print(weather_condition: str):
    print(f"Today the weather is {weather_condition}")

while True:

    if blueButton.value:
        # the main button has been pressed
        if xDir.value == yDir.value:
            weather_print("sunny and clear.")
        elif xDir.value == 0:
            weather_print("rainy and stormy.")
        elif yDir.value == 0:
            weather_print("eerily calm.")

    # uncomment for debugging purposes
    # print(f"xDir: {xDir.value}")
    # print(f"yDir: {yDir.value}")
    # print(f"Joy Button: {button.value}")
    # print(F"Blue Button: {blueButton.value}")
    sleep(0.1)
