#include "view/leds.h"
#include <Adafruit_NeoPixel.h>

Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

void setupLeds(){
  pixels.begin(); // INITIALIZE NeoPixel strip object (REQUIRED)
}

void showLeds() {
  pixels.clear(); 
  for(int i=0; i<NUMPIXELS; i++) { 
    pixels.setPixelColor(i, pixels.Color(15, 15, 15));
    // pixels.show();
  }
}