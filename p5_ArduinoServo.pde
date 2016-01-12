import oscP5.*;        //  Load OSC P5 library
import netP5.*;        //  Load net P5 library
import processing.serial.*;    //  Load serial library

Serial arduinoPort;        //  Set arduinoPort as serial connection
OscP5 oscP5;            //  Set oscP5 as OSC connection

int redLED = 0;        //  redLED lets us know if the LED is on or off
int [] led = new int [5];    //  Array allows us to add more toggle buttons in TouchOSC
float v_push1 = 0.0f;
float v_push2 = 0.0f;

void setup() {
  size(100,100);        // Processing screen size
  noStroke();            // We don’t want an outline or Stroke on our graphics
  oscP5 = new OscP5(this,8000);  // Start oscP5, listening for incoming messages at port 8000
  arduinoPort = new Serial(this, Serial.list()[3], 9600);    // Set arduino to 9600 baud
  print(Serial.list()[3]);
}

void oscEvent(OscMessage theOscMessage) {   // This runs whenever there is a new OSC message
    String addr = theOscMessage.addrPattern();  // Creates a string out of the OSC message
    float val = theOscMessage.get(0).floatValue();
    if(addr.equals("/1/push1")) { v_push1 = val; }
    else if(addr.equals("/1/push2")) { v_push2 = val; }
}

void draw() {
 background(50);        // Sets the background to a dark grey, can be 0-255
 if(v_push1 == 1){        //  If led button 1 if off do....
    arduinoPort.write("F");    // Sends the character “r” to Arduino
    redLED = 0;        // Sets redLED color to 0, can be 0-255
  }
 if(v_push2 == 1){        // If led button 1 is ON do...
  arduinoPort.write("B");    // Send the character “R” to Arduino
  redLED = 255;        // Sets redLED color to 255, can be 0-255
  }
 fill(redLED,0,0);            // Fill rectangle with redLED amount
 ellipse(50, 50, 50, 50);    // Created an ellipse at 50 pixels from the left...
                // 50 pixels from the top and a width of 50 and height of 50 pixels
}