int VRX_PIN = 22;
int VRY_PIN = 23;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(VRX_PIN, INPUT);
  pinMode(VRY_PIN, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  float vrxVal = analogRead(VRX_PIN);
  float vryVal = analogRead(VRY_PIN);
  Serial.print("VRX: ");
  Serial.println(vrxVal);
  Serial.print("VRY: ");
  Serial.println(vryVal);
}
