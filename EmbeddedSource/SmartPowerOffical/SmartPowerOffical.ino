#include "include.h"

unsigned long lastMillis = 0;

void setup() {
  setupDisplay();
  setupWiFi();
}

void showDisplay() {
  float v = pzem.voltage(ip);
  if (v >= 0.01) {
    last_voltage = v;  //V
  }
  float i = pzem.current(ip);
  if (i >= 0.01) {
    last_current = i;     //A
  }
  float p = pzem.power(ip);
  if (p >= 0.01) {
    last_power = p;        //W
  }
  float e = pzem.energy(ip);
  if (e >= 0.01) {
    last_energy = e;   ///Wh
  }
  cs = e / 1000;
  is = p / v;
  display.clear();
  display.drawString(0, 0, "Voltage: " + String(v) + " V\t");
  display.drawString(0, 16, "Ampe: " + String(is) + " A");
  display.drawString(0, 32, "Power: " + String(p) + " W");
  display.drawString(0, 48, "Ene: " + String(cs) + " kWh\t");
  display.display();
  delay(5000);
}
void loop() {
  showDisplay();
  if(last_voltage >= 0.01){
    sentData();
  }
}

void sentData()
{
  Firebase.setFloat("Power/Current/value", is);
  delay(100);
  Firebase.setFloat("Power/Energy/value", cs);
  delay(100);
  Firebase.setFloat("Power/Power/value", last_power);
  delay(100);
  Firebase.setFloat("Power/Power/value10/value", last_power);
  delay(100);
  Firebase.setFloat("Power/Voltage/value", last_voltage);
  delay(100);
}


void setupDisplay(){
    display.init();
  display.flipScreenVertically();
  display.setFont(ArialMT_Plain_16);
  display.setTextAlignment(TEXT_ALIGN_LEFT);
  display.clear();          
  display.drawString(15, 0,  "   Smart Connect  ");
  display.drawString(15, 16, "   PZEM 004T");
  display.drawString(0, 32, "Wait WiFi");
  display.drawString(0, 48, "    Connect........");
  display.display();
  pzem.setAddress(ip);
}

void setupWiFi() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.stream(PATH);
}
