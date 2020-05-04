#include "include.h"
unsigned long previousMillis = 0;
int count = 0;
void setup() {
  setPinModes();
  dht.begin();
  button1.attachClick(click1);
  button2.attachClick(click2);
  button3.attachClick(click3);
  setupWiFi();
  getValue();
}

void loop() {
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= 10000) {
    previousMillis = currentMillis;
    rsdSensor();
  }
   btnClick();
   readEvent(); 
   yield();
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


void setPinModes() {
  pinMode(RL1, OUTPUT);
  pinMode(RL2, OUTPUT);
  pinMode(RL3, OUTPUT);
  digitalWrite(RL2, 1);
  digitalWrite(RL1, 1);
  digitalWrite(RL3, 1);
}

void debug() {
  Serial.println("Trạng thái Temp = " + String(lasttemp) + "*C    --  Trạng thái Humi = " + String(lasthumi) + "%");
}


void readEvent() {

  if (Firebase.failed()) {
    Serial.println(Firebase.error());
  }

  if (Firebase.available()) {
    FirebaseObject event = Firebase.readEvent();
    if (event.success()) {
      // Lấy dữ liệu đã thay đổi trên firebase
      String path = event.getString("path");
      int data = event.getInt("data");
      if(path == "/Device1/value" || path == "/Device2/value" || path == "/Device3/value")
      {
      handingeventbtn(path, data);
      }
    }
  }
}

void handingeventbtn(String path, int data) {
  /*
     path = /Button/Btn1;
     data = 20
  */
  Serial.println("handingData  " +  path + "=" + String(data));

  if (path == "/Device1/value") {
    data == 1 ? digitalWrite(RL1,0) : digitalWrite(RL1,1);
  } else if (path == "/Device2/value") {
    data == 1 ? digitalWrite(RL2,0) : digitalWrite(RL2,1);
  } else if (path == "/Device3/value") {
    data == 1 ? digitalWrite(RL3,0) : digitalWrite(RL3,1);
  } 
}


void click1() {
  if(digitalRead(RL1) == 0){
  Firebase.setInt("Devices/Device1/value", 0);
  }else{
   Firebase.setInt("Devices/Device1/value", 1);
  }
}

void click2() {
    if(digitalRead(RL2) == 0){
  Firebase.setInt("Devices/Device2/value", 0);
  }else{
   Firebase.setInt("Devices/Device2/value", 1);
  }
}

void click3() {
   if(digitalRead(RL3) == 0){
  Firebase.setInt("Devices/Device3/value", 0);
  }else{
   Firebase.setInt("Devices/Device3/value", 1);
  }
}

void btnClick() {
  button1.tick();
  button2.tick();
  button3.tick();
}

void blinkCheck() {
  digitalWrite(RL1, LOW);
  delay(500);
  digitalWrite(RL1, HIGH);
  delay(500);
}

void getValue() {
  //Value of Controller
  FirebaseObject getControlelrObject = Firebase.get("Devices/");
  digitalWrite(RL1, getControlelrObject.getInt("Device1/value") == 1 ? 0 : 1 );
  digitalWrite(RL2, getControlelrObject.getInt("Device2/value") == 1 ? 0 : 1 );
  digitalWrite(RL3, getControlelrObject.getInt("Device3/value") == 1 ? 0 : 1 );
  yield();
}

void rsdSensor() {
  lasthumi = dht.readHumidity();
  lasttemp = dht.readTemperature();
//  if (isnan(lasthumi) || isnan(lasttemp)) {
//    Serial.println(F("Failed to read from DHT sensor!"));
//    return;
//  }
  debug();
  if(lasthumi != 0.0 && lasttemp != 0.0){
  Firebase.setFloat("Devices/Humi", lasthumi);
  Firebase.setFloat("Devices/Temp", lasttemp);
  }

}
