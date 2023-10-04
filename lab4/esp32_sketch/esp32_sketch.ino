int VRX_PIN = 34;
int VRY_PIN = 35;
int OUT_PIN = 16;
int JBUTTON = 5;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(VRX_PIN, INPUT);
  pinMode(VRY_PIN, INPUT);
  pinMode(OUT_PIN, OUTPUT);
  pinMode(JBUTTON, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  String printOut = "VRX: ";
  printOut += analogRead(VRX_PIN);
  printOut += " VRY: ";
  printOut += analogRead(VRY_PIN);
  // Serial.println("VRX: " + analogRead(VRX_PIN) + " VRY: " + analogRead(VRY_PIN));
  // Serial.println(printOut);
  Serial.println("Button: " + digitalRead(JBUTTON));
}