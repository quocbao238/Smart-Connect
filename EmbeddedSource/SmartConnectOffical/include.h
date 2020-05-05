#define RL1 16
#define RL2 14
#define RL3 12
#define Btn1 13
#define Btn2 5
#define Btn3 4
//#define SHT_XANH 0
//#define SHT_VANG 2
double value,lasttemp,lasthumi;
float temp,humidity;
int tmpstateTemp,tmpstateHumi,DifHumi,DifTemp;
float lastTemp,lastHumi;
String stateTemp,stateHumi;
int statusTemp =0 ,statusHumi = 0; /// status = 1 when on , status = 0 when off;
#include "SimpleTimer.h"
#include "OneButton.h"
#include <ESP8266WiFi.h>
#include "FirebaseArduino.h"
#include "DHT.h"
#define DHTPIN2 0
#define DHTTYPE DHT22 

#define PATH "/Devices"
#define FIREBASE_HOST "smart-connect-b2f56.firebaseio.com" // Firebase address
#define FIREBASE_AUTH ""   
#define WIFI_SSID "WiFi"   //    Edit your wifi
#define WIFI_PASSWORD "Password" // Edit your password
OneButton button1(Btn1, true);
OneButton button2(Btn2, true);
OneButton button3(Btn3, true);
SimpleTimer srd_Timer;
DHT dht(DHTPIN, DHTTYPE);
