from gpiozero import Button
from time import sleep

button = Button(2)

while True:
    print(f"Is pressed: {button.is_pressed()}")
    sleep(0.1)    

