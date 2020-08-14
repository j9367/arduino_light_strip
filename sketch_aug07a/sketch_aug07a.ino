#include <Adafruit_NeoPixel.h>

#define PIN    4

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS  7

// NeoPixel brightness, 0 (min) to 255 (max)
#define BRIGHTNESS 50
#ifdef __AVR__
#include <avr/power.h>
#endif

#include "BluetoothSerial.h"
#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;

IPAddress staticIP(192, 168, 0, 241);  
IPAddress gateway(192, 168, 0, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress dns(192, 168, 0, 1);

// Declare our NeoPixel strip objects
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

#include <WiFi.h>

TaskHandle_t Task1;
TaskHandle_t Task2;

#define DELAYVAL 100

const char* ssid = "Vasilis's Wi-Fi Network";    //  Your Wi-Fi Name

const char* password = "Corunna60";   // Wi-Fi Password

WiFiServer server(80); //opens port 80 to web server

String header;

String state = "on";

int pos1;
int pos2;
int pos3;
int pos4;


String redString = "0";
String greenString = "0";
String blueString = "0";

void setup() {
  // put your setup code here, to run once:

   pixels.begin();           // INITIALIZE NeoPixel strip object (REQUIRED)
  pixels.clear();            // Turn OFF all pixels ASAP
  pixels.setBrightness(0);
  pixels.show();


Serial.begin(115200);

 SerialBT.begin("ESP32NeopixelLightStrip");
  
WiFi.config(staticIP, gateway, subnet, dns);
  
  WiFi.begin(ssid, password); //starts the wifi connection

while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi..");
  }
 
  Serial.println("Connected to the WiFi network");

  server.begin();
  
Serial.println(WiFi.localIP());

   xTaskCreatePinnedToCore(
    wifiTaskArduino, /* Function to implement the task */
      "Task1", /* Name of the task */
      10000,  /* Stack size in words */
      NULL,  /* Task input parameter */
      0,  /* Priority of the task */
      &Task1,  /* Task handle. */
      0); /* Core where the task should run */                
               /* Task handle. */

       xTaskCreatePinnedToCore(
    myTask2, /* Function to implement the task */
      "Task2", /* Name of the task */
      10000,  /* Stack size in words */
      NULL,  /* Task input parameter */
      0,  /* Priority of the task */
      &Task2,  /* Task handle. */
      1);
}
  


void loop() {
  // put your main code here, to run repeatedly:

}

void wifiTaskArduino( void * pvParameters ) {

for(;;) {
  
    
    while (1) {
   WiFiClient client = server.available();

    if (client) {
      Serial.println("New Client.");
      String currentLine = "";
      Serial.printf("connected: %d\n", (int)client.connected());
      while (client.connected()) {

        if (client.available()) {
          char c = client.read();
          //          Serial.write(c);
          header += c;
          if (c == '\n') {
            if (currentLine.length() == 0) {
              client.println("HTTP/1.1 200 OK");
              client.println("Content-type:text/html");
              client.println("Connection: close");
              client.println();

              if (header.indexOf("GET /Rainbow") >= 0) {
                Serial.println("1");
                  pixels.setBrightness(50);
                while (state == "on"){
                pattern();
                 if (WiFiClient client = server.available()){

                 header = client.readStringUntil('\r');
                 
                if (header.indexOf("GET /OFF") >= 0) {
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                }
                    }
                }
              }
              if (header.indexOf("GET /Police") >= 0) {
                pixels.setBrightness(50);
               while (state == "on"){
                pattern2();
                 if (WiFiClient client = server.available()){
                 header = client.readStringUntil('\r');
                if (header.indexOf("GET /OFF") >= 0) {
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                    }
                }
              }
              }
              
              if (header.indexOf("GET /Strobe") >= 0) {
                pixels.setBrightness(50);
                while (state == "on"){
                  pattern3();
                   if (WiFiClient client = server.available()){

                 header = client.readStringUntil('\r');
                  if (header.indexOf("GET /OFF") >= 0) {
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                    }
                  }
              }
              }
              
              if (header.indexOf("GET /Blue") >= 0) {
                 Serial.println("4");
                 pixels.clear();
                  pixels.setBrightness(50);

                  while (state == "on"){
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-4, pixels.Color(0,0,255));
   
   pixels.setPixelColor(i-4, pixels.Color(0,0,255));
   pixels.show();
    pixels.show();
          }
                  if (WiFiClient client = server.available()){

                 header = client.readStringUntil('\r');
                 
                  if (header.indexOf("GET/OFF") >= 0){
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                    }
                  
                  }
                 
              }
              }
              
              if (header.indexOf("GET /Red") >= 0) {
                Serial.println("5");
                 pixels.clear();
                 pixels.setBrightness(50);

                 while(state == "on"){
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-4, pixels.Color(255,0,0));
   
   pixels.setPixelColor(i-4, pixels.Color(255,0,255));
       pixels.show();
    pixels.show();
          }
               if (WiFiClient client = server.available()){
                  header = client.readStringUntil('\r');
                   if (header.indexOf("GET/OFF") >= 0){
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                    }
                }   
                 
                 }
                 
              }
              

              if (header.indexOf("GET /Green") >= 0) {
                Serial.println("5");
                 pixels.clear();
                 pixels.setBrightness(50);

                 while(state == "on"){
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-4, pixels.Color(0,255,0));
   
   pixels.setPixelColor(i-4, pixels.Color(0,255,0));
    pixels.show();
    pixels.show();
          }
                 if (WiFiClient client = server.available()){
                  header = client.readStringUntil('\r');
                   if (header.indexOf("GET/OFF") >= 0){
                    pixels.setBrightness(0);
                    pixels.clear();
                    pixels.show();
                    pixels.show();
                    break;
                    }
                }
                 
                 }
   
                 
              }
              
          
              if (header.indexOf("GET /OFF") >= 0) {
                 pixels.setBrightness(0);
                 pixels.clear();
                 pixels.show();
                 pixels.show();
              }

              if (header.indexOf("GET /Colopicke") >= 0){
              pos1 = header.indexOf('r');
              pos2 = header.indexOf('g');
              pos3 = header.indexOf('b');
              pos4 = header.indexOf('&');
              redString = header.substring(pos1+1, pos2);
              greenString = header.substring(pos2+1, pos3);
              blueString = header.substring(pos3+1, pos4);
              Serial.println(redString.toInt());
              Serial.println(greenString.toInt());
              Serial.println(blueString.toInt());
                pixels.setBrightness(50);
                for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
          pixels.setPixelColor(i-3, pixels.Color(redString.toInt(), greenString.toInt(), blueString.toInt()));
          }
          pixels.show();
          pixels.show();
                }

              // Head
              client.println("<!DOCTYPE html><html>");
              
              // Body
              client.println("<body><h1>ESP32 Web RGB strip control</h1>");
              client.print("<p><a href=\"/");
              client.print("\"><button class=\"button\">");
             
              client.println("</button></a></p>");
              client.println("</body></html>");

              client.println();
              break;
        }else {
              currentLine = "";
            }
           if (c != '\r') {
            currentLine += c;
           }  
          }
        }
        }
      }

      header = "";

      client.stop();
      Serial.println("Client disconnected.");
      Serial.println("");
    
    }
  }
}

  
  
  
  


void pattern() //function for light patterns
{
    for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
          //Change the value of the (?,?,?) to create the color you want in RGB values
          pixels.setPixelColor(i-14, pixels.Color(255,0,0));
          pixels.setPixelColor(i-13, pixels.Color(255,165,0));
          pixels.setPixelColor(i-12, pixels.Color(255,255,0));
          pixels.setPixelColor(i-11, pixels.Color(0,128,0));
          pixels.setPixelColor(i-10, pixels.Color(0,191,255));
          pixels.setPixelColor(i-9, pixels.Color(75,0,130));
          pixels.setPixelColor(i-8, pixels.Color(128,0,128));
          pixels.setPixelColor(i-7, pixels.Color(255,0,0));
          pixels.setPixelColor(i-6, pixels.Color(128,0,128));
          pixels.setPixelColor(i-5, pixels.Color(75,0,130));
          pixels.setPixelColor(i-4, pixels.Color(0,191,255));
          pixels.setPixelColor(i-3, pixels.Color(0,128,0));
          pixels.setPixelColor(i-2, pixels.Color(255,255,0));
          pixels.setPixelColor(i-1, pixels.Color(255,165,0));
          pixels.setPixelColor(i, pixels.Color(255,0,0));
          pixels.setPixelColor(i+1, pixels.Color(255,165,0));
          pixels.setPixelColor(i+2, pixels.Color(255,255,0));
          pixels.setPixelColor(i+3, pixels.Color(0,128,0));
          pixels.setPixelColor(i+4, pixels.Color(0,191,255));
          pixels.setPixelColor(i+5, pixels.Color(75,0,130));
          pixels.setPixelColor(i+6, pixels.Color(128,0,128));
          pixels.setPixelColor(i+7, pixels.Color(255,0,0));
          pixels.setPixelColor(i+8, pixels.Color(128,0,128));
          pixels.show(); //Turn the pixels on
          pixels.show();
          delay(DELAYVAL); //Wait delay value before moving on to the next pixel
          }
        }

        void pattern2(){
  // Set all pixel colors to 'off'
for(int i=0; i<4; i=i+3)// This is the set up for the cycle of color spread then clear
  {
  //Change the value of the (?,?,?) to create the color you want in RGB values
  pixels.setPixelColor(i-8, pixels.Color(255,0,0));
  pixels.setPixelColor(i-7, pixels.Color(255,0,0));
  pixels.setPixelColor(i-6, pixels.Color(0,0,255));
  pixels.setPixelColor(i-5, pixels.Color(0,0,255));
  pixels.setPixelColor(i-4, pixels.Color(0,0,255));
  pixels.setPixelColor(i-3, pixels.Color(255,0,0));
  pixels.setPixelColor(i-2, pixels.Color(255,0,0));
  pixels.setPixelColor(i-1, pixels.Color(255,0,0));
  pixels.setPixelColor(i, pixels.Color(0,0,255));
  pixels.setPixelColor(i+1, pixels.Color(0,0,255));
  pixels.setPixelColor(i+2, pixels.Color(0,0,255));
  pixels.setPixelColor(i+3, pixels.Color(255,0,0));
  pixels.setPixelColor(i+4, pixels.Color(255,0,0));
  pixels.setPixelColor(i+5, pixels.Color(255,0,0));
  pixels.setPixelColor(i+6, pixels.Color(0,0,255));
  pixels.setPixelColor(i+7, pixels.Color(0,0,255));
  pixels.setPixelColor(i+8, pixels.Color(0,0,255));
  pixels.show(); //Turn the pixels on
  pixels.show();
  delay(DELAYVAL); //Wait delay value before moving on to the next pixel
}
}

void pattern3()
{
pixels.clear(); // Set all pixel colors to 'off'
for(int i=0; i<8; i++)// This is the set up for the cycle of color spread then clear
    
  {
  //Change the value of the (?,?,?) to create the color you want in RGB values

  pixels.setPixelColor(i-8, pixels.Color(255,255,255));
  pixels.setPixelColor(i-7, pixels.Color(0,0,0));
  pixels.setPixelColor(i-6, pixels.Color(255,255,255));
  pixels.setPixelColor(i-5, pixels.Color(0,0,0));
  pixels.setPixelColor(i-4, pixels.Color(255,255,255));
  pixels.setPixelColor(i-3, pixels.Color(0,0,0));
  pixels.setPixelColor(i-2, pixels.Color(255,255,255));
  pixels.setPixelColor(i-1, pixels.Color(0,0,0));
  pixels.setPixelColor(i, pixels.Color(255,255,255));
  pixels.setPixelColor(i+1, pixels.Color(0,0,0));
  pixels.setPixelColor(i+2, pixels.Color(255,255,255));
  pixels.setPixelColor(i+3, pixels.Color(0,0,0));
  pixels.setPixelColor(i+4, pixels.Color(255,255,255));
  pixels.setPixelColor(i+5, pixels.Color(0,0,0));
  pixels.setPixelColor(i+6, pixels.Color(255,255,255));
  pixels.setPixelColor(i+7, pixels.Color(0,0,0));
  pixels.setPixelColor(i+8, pixels.Color(255,255,255));
  pixels.show();//Turn the pixels on
  pixels.show();
  delay(DELAYVAL);
  }
}

void myTask2( void * pvParameters ){
  for (;;){
    if (Serial.available()) {
  SerialBT.write(IPAddress);
}
    }
  }
