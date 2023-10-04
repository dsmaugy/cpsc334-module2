# Task 1

`task1.py` is a Python program that demonstrates a text program with three different modes of operation.
The hardware required to run `task1.py` is an analog joystick and a push button.

When the push button is pressed, a message will be printed out in the following format:
```
Today the weather is <weather_condition>
```

where `<weather_condition>` is different depending on the settings of the joystick.

If the x and y values of the joystick are the same, the weather condition is "sunny and clear".
Otherwise if x == 0 then the weather condition is "rainy and stormy" and if y == 0 then the weather is "eerily calm".
