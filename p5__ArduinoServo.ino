#include <Servo.h>

Servo me;
float val=0.000f;
int message=0;
int ledpin=9;

void setup()
{  
  Serial.begin(9600);
  me.attach(ledpin);
  pinMode(11, OUTPUT);
}

void loop()
{ 
   if(Serial.available()>0){
     message = Serial.read();
     digitalWrite(11,HIGH);
    if(val<179 && message == 'F'){
      val= val + 1;
      me.write(val);
      delay(5);
      Serial.println(val);
    }if(message == 'B'){
      me.write(val);
      val = val - 1;
      delay(5);
      Serial.println(val);
    }
    
   }
   
   
}    


