from gpiozero import Button
from time import sleep

button = Button(2)

while True:
    print(f"Is pressed: {button.value}")
    sleep(0.1)    

