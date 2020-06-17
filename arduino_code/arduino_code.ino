#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
 #include <avr/power.h> // Required for 16 MHz Adafruit Trinket
#endif
#define PIN    2

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS  7

// NeoPixel brightness, 0 (min) to 255 (max)
#define BRIGHTNESS 50

// Declare our NeoPixel strip objects
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

#include <ESP8266WiFi.h>

#define DELAYVAL 100
 

const char* ssid = "iPhone";    //  Your Wi-Fi Name

const char* password = "Corunna60!";   // Wi-Fi Password

const char* State = "on"; //forces while loop


WiFiServer server(80); //opens port 80 to web server

String redString = "0";
String greenString = "0";
String blueString = "0";
int pos1 = 0;
int pos2 = 0;
int pos3 = 0;
int pos4 = 0;

// Variable to store the HTTP req  uest
String header;

  

// Setting PWM bit resolution
const int resolution = 256;

// Current time
unsigned long currentTime = millis();
// Previous time
unsigned long previousTime = 0; 
// Define timeout time in milliseconds (example: 2000ms = 2s)
const long timeoutTime = 5000;


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

  WiFi.begin(ssid, password); //starts the wifi connection

  IPAddress ip(172, 20, 10, 11);  

  while (WiFi.status() != WL_CONNECTED) //checks wifi is connected

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

  WiFiClient client = server.available(); //makes server avaliable to new client

  if (!client) //checks for client

  {

    return;

  }

  Serial.println("Waiting for new client"); //waits for client if they disconnect it restarts the process

  while(!client.available())

  {

    delay(1);
    break;
  }

 

  String request = client.readStringUntil('\r'); //reads end of URL and runs functions

  Serial.println(request);

  client.flush();

  int value = LOW;


  if(request.indexOf("/LED=OFF") != -1) //one instance of the end of a url

  {

    pixels.setBrightness(0); //makes sure strip is off
pixels.clear(); //clears previous code
    pixels.show(); //makes sure this is shown
    value = LOW; //sets value to low on web interface
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /LED=OFF HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println(""); 
      client.stop(); //disconnects client

  }


  if(request.indexOf("/Strip=RED") != -1){ //process repeats
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
  while(State == "on"){ //used with light patterns forces a loop
 
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

   if(request.indexOf("/colopicke") != -1)
  {
    client.println("HTTP/1.1 200 OK"); 
      client.println("POST /colopicke HTTP/1.1");
      client.println("Connection: close");
       client.println("Content-Type: application/json");
       client.println("Cache-Control: no cache");
      client.println("");
      client.stop();
      Serial.print("client socket closed");
   while(State = "on"){
    colorpicker();
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

    Serial.print("off");
    break;
  }
   }
    
   } 
  }
        
      
    
//*------------------HTML Page Code---------------------*//

 

  client.println("HTTP/1.1 200 OK"); //setus up a webpage

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

    client.println("<a href=\"/colorpicker\"\"><button>colorpicker</button></a><br />");
     
  client.println("<form action='/colorpicker\' method='post' enctype='multipart/form-data'>");
 
  client.println("<input type='range' min='1' max='100' value='50' class='slider' id='slider'>");
  
  client.println("<input type='submit' value=''>");
 
  client.println("</form>");
  
  client.println("</html>");

 

  delay(1);

  Serial.println("Client disonnected");

  Serial.println("");

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

void colorpicker(){
 WiFiClient client = server.available();   // Listen for incoming clients

  if (client) {                             // If a new client connects,
    currentTime = millis();
    previousTime = currentTime;
    Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    while (client.connected() && currentTime - previousTime <= timeoutTime) {            // loop while the client's connected
      currentTime = millis();
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
                   
            // Display the HTML web page
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            client.println("<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\">");
            client.println("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jscolor/2.0.4/jscolor.min.js\"></script>");
            client.println("</head><body><div class=\"container\"><div class=\"row\"><h1>ESP Color Picker</h1></div>");
            client.println("<a class=\"btn btn-primary btn-lg\" href=\"#\" id=\"change_color\" role=\"button\">Change Color</a> ");
            client.println("<input class=\"jscolor {onFineChange:'update(this)'}\" id=\"rgb\"></div>");
            client.println("<script>function update(picker) {document.getElementById('rgb').innerHTML = Math.round(picker.rgb[0]) + ', ' +  Math.round(picker.rgb[1]) + ', ' + Math.round(picker.rgb[2]);");
            client.println("document.getElementById(\"change_color\").href=\"?r\" + Math.round(picker.rgb[0]) + \"g\" +  Math.round(picker.rgb[1]) + \"b\" + Math.round(picker.rgb[2]) + \"&\";}</script></body></html>");
            // The HTTP response ends with another blank line
            client.println();

            // Request sample: /?r201g32b255&
            // Red = 201 | Green = 32 | Blue = 255
            

           
             
 
            if(header.indexOf("GET /colopicke?r") >= 0) {
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
             break;
            }
            // Break out of the while loop
           break;
           
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}
