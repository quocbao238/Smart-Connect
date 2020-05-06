#include <PZEM004T.h> //https://github.com/olehs/PZEM004T
PZEM004T pzem(&Serial);                                        /// use Serial
IPAddress ip(192, 168, 1, 1);
#include <Wire.h>  // Only needed for Arduino 1.6.5 and earlier
#include "SSD1306.h" // alias for `#include "SSD1306Wire.h"`
#include <ESP8266WiFi.h>
#include "FirebaseArduino.h"

#define PATH "/Devices"
#define FIREBASE_HOST "url Firebae" // Firebase address
#define FIREBASE_AUTH ""   
#define WIFI_SSID "WiFi"   //    Edit your wifi
#define WIFI_PASSWORD "Password" // 
SSD1306  display(0x3c, 4, 5);
#define  LED 2

float last_voltage = 0;
float last_current = 0;
float last_power = 0;
float last_energy = 0; 
float cs = 0;
float is = 0;
