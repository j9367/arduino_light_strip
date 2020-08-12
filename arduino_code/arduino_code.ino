#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
 #include <avr/power.h> // Required for 16 MHz Adafruit Trinket
#endif
#define PIN    2

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS  8

// NeoPixel brightness, 0 (min) to 255 (max)
#define BRIGHTNESS 50

// Declare our NeoPixel strip objects
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

#include <ESP8266WiFi.h>

#define DELAYVAL 100
 

const char* ssid = "James iPhone";    //  Your Wi-Fi Name

const char* password = "TestingCode";   // Wi-Fi Password

const char* State = "on";

WiFiServer server(80); 




void setup()

{
  // These lines are specifically to support the Adafruit Trinket 5V 16 MHz.
  // Any other board, you can remove this part (but no harm leaving it):
#if defined(__AVR_ATtiny85__) && (F_CPU == 16000000)
  clock_prescale_set(clock_div_1);
#endif
  // END of Trinket-specific code.

  pixels.begin();           // INITIALIZE NeoPixel strip object (REQUIRED)
  pixels.clear();            // Turn OFF all pixels ASAP
  pixels.setBrightness(0);
  pixels.show();
  Serial.begin(115200); //Default Baudrate

  Serial.print("Connecting to the Newtork");

  WiFi.begin(ssid, password);

  IPAddress ip(172, 20, 10, 42);  

  while (WiFi.status() != WL_CONNECTED)

  {

    delay(500);

    Serial.print(".");

  }

  Serial.println("WiFi connected"); 

  server.begin();  // Starts the Server

  Serial.println("Server started");

 

  Serial.print("IP Address of network: "); // will IP address on Serial Monitor

  Serial.println(WiFi.localIP());

  Serial.print("Copy and paste the following URL: https://"); // Will print IP address in URL format

  Serial.print(WiFi.localIP());

  Serial.println("/");

}

 

void loop()

{

  WiFiClient client = server.available();

  if (!client)

  {

    return;

  }

  Serial.println("Waiting for new client");

  while(!client.available())

  {

    delay(1);
    break;
  }

 

  String request = client.readStringUntil('\r');

  Serial.println(request);

  client.flush();

  int value = LOW;


  if(request.indexOf("/LED=OFF") != -1)

  {

    pixels.setBrightness(0);
pixels.clear();
    pixels.show();
    value = LOW;
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();

  }


  if(request.indexOf("/Strip=RED") != -1){
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /Strip=RED HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
    pixels.setBrightness(50);
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-2, pixels.Color(255,0,0));
   
   pixels.setPixelColor(i-2, pixels.Color(255,0,0));
          }
    pixels.show();
  value = HIGH;

    }

    if(request.indexOf("/Strip=Green") != -1){
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /Strip=Green HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
    pixels.setBrightness(50);
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-3, pixels.Color(0,255,0));
   
   pixels.setPixelColor(i-3, pixels.Color(0,255,0));
          }
    pixels.show();
  value = HIGH;

    }

if(request.indexOf("/Strip=Blue") != -1){
  client.println("HTTP/1.1 200 OK"); 
      client.println("POST /Strip=Blue HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");  
    pixels.setBrightness(50);
   for(int i=0; i<14; i++)// This is the set up for the cycle of color spread then clear
          {
   pixels.setPixelColor(i-4, pixels.Color(0,0,255));
   
   pixels.setPixelColor(i-4, pixels.Color(0,0,255));
          }
    pixels.show();
  value = HIGH;

    }

if(request.indexOf("/Rainbow") != -1)
  {
      client.println("HTTP/1.1 200 OK"); 
      client.println("POST /Rainbow HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");

  
  pixels.setBrightness(50);
  value = HIGH;
  while(State == "on"){
 
 pattern();
 

 if (WiFiClient client = server.available()){

   String request = client.readStringUntil('\r');

    if(request.indexOf("/LED=OFF") != -1)

  {
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");

    pixels.setBrightness(0);
    pixels.clear();
    pixels.show();
    value = LOW;

    break;
  }
    
   
 }
  }
  }

  if(request.indexOf("/pattern2") != -1)
  {
      client.println("HTTP/1.1 200 OK"); 
      client.println("POST /pattern2 HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");

  
  pixels.setBrightness(50);
  value = HIGH;
  while(State == "on"){
 
 pattern2();
 

 if (WiFiClient client = server.available()){

   String request = client.readStringUntil('\r');

    if(request.indexOf("/LED=OFF") != -1)

  {
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
    pixels.setBrightness(0);
    pixels.clear();
    pixels.show();
    value = LOW;
    Serial.print("off");
    break;
  }
    
   
 }
  }
  }

  if(request.indexOf("/pattern3") != -1)
  {
      client.println("HTTP/1.1 200 OK"); 
      client.println("POST /pattern2 HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");

  
  pixels.setBrightness(50);
  value = HIGH;
  while(State == "on"){
 
 pattern3();
 

 if (WiFiClient client = server.available()){

   String request = client.readStringUntil('\r');

    if(request.indexOf("/LED=OFF") != -1)

  {
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
    pixels.setBrightness(0);
    pixels.clear();
    pixels.show();
    value = LOW;
    Serial.print("off");
    break;
  }
    
   
 }
  }
  }

   if(request.indexOf("/colorpicker") != -1)
  {
      client.println("HTTP/1.1 200 OK"); 
      client.println("POST /pattern2 HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");

  
  pixels.setBrightness(50);
  value = HIGH;
  while(State == "on"){
 
 pattern3();
 

 if (WiFiClient client = server.available()){

   String request = client.readStringUntil('\r');


    
    if(request.indexOf("/LED=OFF") != -1)

  {
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
    pixels.setBrightness(0);
    pixels.clear();
    pixels.show();
    value = LOW;
    Serial.print("off");
    break;
  }
    
   
 }
  }
  }
  
 

//*------------------HTML Page Code---------------------*//

 

  client.println("HTTP/1.1 200 OK"); //

  client.println("Content-Type: text/html");

  client.println("");

  client.println("<!DOCTYPE HTML>");

  client.println("<html>");

 

  client.print(" CONTROL LED: ");

 

  if(value == HIGH)

  {

    client.print("ON");

  }

  else

  {

    client.print("OFF");

  }

  

  client.println("<br><br>");

  client.println("<a href=\"/LED=OFF\"\"><button>OFF</button></a><br />");

  client.println("<a href=\"/Strip=RED\"\"><button>RED</button></a><br />");
  
  client.println("<a href=\"/Strip=Green\"\"><button>Green</button></a><br />");

   client.println("<a href=\"/Strip=Blue\"\"><button>Blue</button></a><br />");
  
  client.println("<a href=\"/Rainbow\"\"><button>Rainbow</button></a><br />");
   
  client.println("<a href=\"/pattern2\"\"><button>Pattern 2</button></a><br />");
    
  client.println("</html>");

 

  delay(1);

  Serial.println("Client disonnected");

  Serial.println("");

}


void pattern()
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
  pixels.show(); //Turn the pixels on
  delay(DELAYVAL);
  }
}
