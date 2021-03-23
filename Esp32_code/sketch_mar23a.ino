#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

int LED_BUILTIN = 2;
bool isUnlock = false;
DynamicJsonDocument doc(32);

 
void setup () {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
  WiFi.begin("AndroidAP_6706", "helloworld");


  while (WiFi.status() != WL_CONNECTED) {
 
    delay(1000);
    Serial.println("Connecting..");
 
  }
  Serial.println("Connected to WiFi Network");
}
 
void loop() {
 
  if (WiFi.status() == WL_CONNECTED) { //Check WiFi connection status
 
    HTTPClient http;  //Declare an object of class HTTPClient
    http.useHTTP10(true);
 
    http.begin("http://192.168.43.78:8090/read"); //Specify request destination
    http.GET(); //Send the request
 
    //if (http.GET() > 0) { //Check the returning code
      DeserializationError error = deserializeJson(doc, http.getStream());
      if (error) {
        Serial.print(F("deserializeJson() failed: "));
        Serial.println(error.f_str());
        return;
      }
      int foo = doc["foo"]; // 0
      Serial.println(foo);             //Print the response payload
      isUnlock = (bool)foo;
      Serial.println(isUnlock);
    //}
    //else Serial.println("An error ocurred");
 
    http.end();   //Close connection

    if(isUnlock)
    {
      digitalWrite(LED_BUILTIN, HIGH);
    }
    else if(!isUnlock)
    {
      digitalWrite(LED_BUILTIN, LOW);
    }
  }
 
  delay(1000);    //Send a request every 10 seconds
 
}
