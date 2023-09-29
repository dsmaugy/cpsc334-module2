int VRX_PIN = 4;
int VRY_PIN = 0;
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
  float vrxVal = analogRead(VRX_PIN);
  float vryVal = analogRead(VRY_PIN);
  Serial.print("VRX: ");
  Serial.println(vrxVal);
  Serial.print("VRY: ");
  Serial.println(vryVal);
  // Serial.println("Button: " + digitalRead(JBUTTON));
}
