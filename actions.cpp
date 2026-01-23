#include "midi/midi.h"
#include "core/actions.h"
#include "core/controls.h"
#include "view/display.h"


void onButtonShortPress(uint8_t idx) {   
    uint8_t channel = controls.getButtonShort(idx).channel;
    ControlMidiType type = controls.getButtonShort(idx).type;
    uint8_t number = controls.getButtonShort(idx).number;
    sendMidiMessage( type, number, 127, channel);
    delay(10);
    sendMidiMessage( type, number, 0, channel);
}

void onButtonLongPress(uint8_t idx) {
    controls.setPreset(idx);

    for(int i = 0; i < 8; ++i) {
        char buf[24];
        int number = controls.getEncoder(i).number;
        int channel = controls.getEncoder(i).channel;
        snprintf(buf, sizeof(buf), "CC %d/%d", number, channel + 1);
        faders[i]->setParamName(buf);
        controls.setEncoder(i, MIDI_CC, number, channel);
    }
    uint8_t packet[5] = { 240, 111, 4, idx, 247 };
    usb_midi.writePacket(packet);
    usb_midi.write(packet, 5);

    uint8_t channel = controls.getButtonLong(idx).channel;
    ControlMidiType type = controls.getButtonLong(idx).type;
    uint8_t number = controls.getButtonLong(idx).number;
    sendMidiMessage(type, number, 127, channel);
    sendMidiMessage(type, number, 0, channel);
}

void onEncoderChange(uint8_t idx, int value) {
    uint8_t channel = controls.getEncoder(idx).channel;
    ControlMidiType type = controls.getEncoder(idx).type;
    uint8_t number = controls.getEncoder(idx).number;
    controls.setEncoderValue(idx, value);
    sendMidiMessage(type, number, value, channel);

    updateFader(idx, value);
}