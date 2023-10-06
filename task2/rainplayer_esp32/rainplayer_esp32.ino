int VRX_PIN = 34;
int VRY_PIN = 35;
int SWITCH_PIN = 25;
int BUTTON_PIN = 19;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(VRX_PIN, INPUT);
  pinMode(VRY_PIN, INPUT);
  pinMode(SWITCH_PIN, INPUT_PULLUP);
  pinMode(BUTTON_PIN, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  // Serial.println(String("VRX: ") + analogRead(VRX_PIN));
  // Serial.println(String("VRY: ") + analogRead(VRY_PIN));
  // Serial.println(String("SWITCH: ") + !digitalRead(SWITCH_PIN));
  // Serial.println(String("BUT: ") + digitalRead(BUTTON_PIN));


  // THIS PRINTS OUT WEIRD STUFF?!?!
  // Serial.println("VRX: " + analogRead(VRX_PIN));
  // Serial.println("VRY: " + analogRead(VRY_PIN));
  // Serial.println("SWITCH: " + digitalRead(SWITCH_PIN));
}
