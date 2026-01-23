#include <Arduino.h>
#include "view/display.h"


FaderWidget* faders[8];


char bank_display_lines[20] = {""};
char device_display_lines[20] = {""};
unsigned long display_start_time = 0;
bool display_active = false;
bool display_needs_update = false;

void setupDisplay() {
    u8g2.begin();
    u8g2_2.begin();

    // u8g2 : 1 2 / 5 6
    faders[0] = new FaderWidget(u8g2,  "Fader 1",   0,   0);    // Bloc 1
    faders[1] = new FaderWidget(u8g2,  "Fader 2", 128,   0);    // Bloc 2
    faders[4] = new FaderWidget(u8g2,  "Fader 5",   0,  32);    // Bloc 5
    faders[5] = new FaderWidget(u8g2,  "Fader 6", 128,  32);    // Bloc 6

    // u8g2_2 : 3 4 / 7 8
    faders[2] = new FaderWidget(u8g2_2, "Fader 3",   0,   0);   // Bloc 3
    faders[3] = new FaderWidget(u8g2_2, "Fader 4", 128,   0);   // Bloc 4
    faders[6] = new FaderWidget(u8g2_2, "Fader 7",   0,  32);   // Bloc 7
    faders[7] = new FaderWidget(u8g2_2, "Fader 8", 128,  32);   // Bloc 8
}

void showDisplay() {
    u8g2.clearBuffer();
    u8g2_2.clearBuffer();
    delay(100); // Laisse le temps à l'écran de se rafraîchir

    for (int i : {0, 1, 4, 5}) {
        faders[i]->draw();
        // delay(10); // Laisse le temps à l'écran de se rafraîchir
    }
    for (int i : {2, 3, 6, 7}) {
        faders[i]->draw();
        // delay(10); // Laisse le temps à l'écran de se rafraîchir
    }
}

void updateFader(int idx, int value) {
    faders[idx]->setValue(value);
}

void updateDisplay() {
    if ((bank_display_lines[0] != '\0' && device_display_lines[0] != '\0') && display_needs_update) {    
        int area_x = 64;
        int area_y = 16; 
        int area_w = 128; // Largeur de la zone d'affichage
        int area_h = 32; // Hauteur de la zone d'affichage
        int text_y = 36;

        u8g2.setDrawColor(0);
        u8g2.drawBox(area_x, area_y, area_w, area_h);
        u8g2.setDrawColor(1);
        u8g2.drawFrame(area_x, area_y, area_w, area_h);
        u8g2.setFont(u8g2_font_7x14B_tr);
        int text_width = u8g2.getStrWidth(device_display_lines);
        int text_x = (256 - text_width) / 2;
        u8g2.setCursor(text_x, text_y); // Ligne 1
        u8g2.print(device_display_lines);
        u8g2.updateDisplayArea(area_x / 8, area_y / 8, area_w / 8, area_h / 8);

        u8g2_2.setDrawColor(0);
        u8g2_2.drawBox(area_x, area_y, area_w, area_h);
        u8g2_2.setDrawColor(1);
        u8g2_2.drawFrame(area_x, area_y, area_w, area_h);
        u8g2_2.setFont(u8g2_font_7x14B_tr);
        text_width = u8g2.getStrWidth(bank_display_lines);
        text_x = (256 - text_width) / 2;
        u8g2_2.setCursor(text_x, text_y); // Ligne 1
        u8g2_2.print(bank_display_lines);
        u8g2_2.updateDisplayArea(area_x / 8, area_y / 8, area_w / 8, area_h / 8);
        display_needs_update = false; // Reset le flag après affichage
    }
    if (display_active && millis() - display_start_time > 800) {
        bank_display_lines[0] = '\0';
        device_display_lines[0] = '\0';
        display_active = false;  
        display_needs_update = false; // Reset le flag après affichage

        showDisplay();
    }
}