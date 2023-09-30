import serial

with serial.Serial("/dev/ttyUSB0", 9600) as ser:
	while True:
		x = ser.readline()
		print(x)
