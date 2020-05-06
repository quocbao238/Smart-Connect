#include "include.h"
#include <ESP8266WiFi.h>
#include <PZEM004T.h> //https://github.com/olehs/PZEM004T
PZEM004T pzem(&Serial);                                        /// use Serial
IPAddress ip(192, 168, 1, 1);
#include <Wire.h>  // Only needed for Arduino 1.6.5 and earlier
#include "SSD1306.h" // alias for `#include "SSD1306Wire.h"`
SSD1306  display(0x3c, 4, 5);
float last_voltage = 0;
float last_current = 0;
float last_power = 0;
float last_energy = 0; 
float cs = 0;
float is = 0;
unsigned long lastMillis = 0;

void setup() {
  pinMode(LED,OUTPUT);
  digitalWrite(LED,LOW);
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
  display.drawString(0, 0, "Voltage: " + String(last_voltage) + " V\t");
  display.drawString(0, 16, "Ampe: " + String(is) + " A");
  display.drawString(0, 32, "Power: " + String(last_power) + " W");
  display.drawString(0, 48, "Ene: " + String(cs) + " kWh\t");
  delay(1000);
  display.display(); 
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
  Firebase.setFloat("Power/Power/value10", last_power);
  delay(100);
  Firebase.setFloat("Power/Voltage/value", last_voltage);
  digitalWrite(LED,LOW);
  delay(100);
  digitalWrite(LED,HIGH);
}


void setupDisplay(){
  display.init();
  display.flipScreenVertically();
  display.setFont(ArialMT_Plain_16);
  display.setTextAlignment(TEXT_ALIGN_LEFT);
  display.clear();
  display.drawString(15, 0, "Electricity Meter");
  display.drawString(15, 16, "   PZEM 004T");
  display.drawString(0, 32, "Wait WiFi");
  display.drawString(0, 48, "    Connected........");
  display.display();
  pzem.setAddress(ip);
}

void setupWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.stream(PATH);
}
