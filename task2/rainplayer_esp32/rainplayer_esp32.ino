int VRX_PIN = 34;
int VRY_PIN = 35;
int SWITCH_PIN = 25;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(VRX_PIN, INPUT);
  pinMode(VRY_PIN, INPUT);
  pinMode(SWITCH_PIN, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  String printOut = "VRX: ";
  printOut += analogRead(VRX_PIN);
  printOut += " VRY: ";
  printOut += analogRead(VRY_PIN);
  printOut += " SWITCH: ";
  printOut += digitalRead(SWITCH_PIN);
  // Serial.println("VRX: " + analogRead(VRX_PIN) + " VRY: " + analogRead(VRY_PIN));
  // Serial.println(printOut);
  Serial.println(String("VRX: ") + analogRead(VRX_PIN));
  Serial.println(String("VRY: ") + analogRead(VRY_PIN));
  Serial.println(String("SWITCH: ") + digitalRead(SWITCH_PIN));

  // THIS PRINTS OUT WEIRD STUFF?!?!
  // Serial.println("VRX: " + analogRead(VRX_PIN));
  // Serial.println("VRY: " + analogRead(VRY_PIN));
  // Serial.println("SWITCH: " + digitalRead(SWITCH_PIN));
}
