#include "core/controls.h"
#include "core/settingsJsonManager.h"
#include "view/display.h"
#include "input/encoders.h"

ControlsManager controls;

ControlsManager::ControlsManager() : _currentPreset(0) {
    // Initialisation par défaut (tout à zéro)
    memset(_presets, 0, sizeof(_presets));
}

void ControlsManager::setPreset(uint8_t preset) {
    if (preset < 8) _currentPreset = preset;
}

uint8_t ControlsManager::getPreset() const {
    return _currentPreset;
}

MidiControl& ControlsManager::getEncoder(uint8_t idx) {
    return _presets[_currentPreset].encoder[idx];
}

MidiControl& ControlsManager::setEncoderValue(uint8_t idx, uint8_t value) {
    if (idx < 8) {
        _presets[_currentPreset].encoder[idx].value = value;
    }
    return _presets[_currentPreset].encoder[idx];
}


MidiControl& ControlsManager::getButtonShort(uint8_t idx) {
    return _presets[_currentPreset].buttons_short[idx];
}

MidiControl& ControlsManager::getButtonLong(uint8_t idx) {
    return _presets[_currentPreset].buttons_long[idx];
}

void ControlsManager::setEncoder(uint8_t idx, ControlMidiType type, uint8_t number, uint8_t channel) {
    if (idx < 8) {
        _presets[_currentPreset].encoder[idx] = {type, number, channel};
    }
}

void ControlsManager::setButtonShort(uint8_t idx, ControlMidiType type, uint8_t number, uint8_t channel) {
    if (idx < 8) {
        _presets[_currentPreset].buttons_short[idx] = {type, number, channel};
    }
}

void ControlsManager::setButtonLong(uint8_t idx, ControlMidiType type, uint8_t number, uint8_t channel) {
    if (idx < 8) {
        _presets[_currentPreset].buttons_long[idx] = {type, number, channel};
    }
}

void ControlsManager::setDefaults() {

    for(int _preset = 0; _preset < 8; ++_preset){
        for(int i = 0; i < 8; ++i) {
            _presets[_preset].encoder[i].type    = static_cast<ControlMidiType>(settings.getEncoder(_preset, i)[0]);
            _presets[_preset].encoder[i].number  = settings.getEncoder(_preset, i)[1];
            _presets[_preset].encoder[i].channel = settings.getEncoder(_preset, i)[2];
            _presets[_preset].buttons_short[i].type    = static_cast<ControlMidiType>(settings.getButtonShort(_preset, i)[0]);
            _presets[_preset].buttons_short[i].number  = settings.getButtonShort(_preset, i)[1];
            _presets[_preset].buttons_short[i].channel = settings.getButtonShort(_preset, i)[2];
            _presets[_preset].buttons_long[i].type    = static_cast<ControlMidiType>(settings.getButtonLong(_preset, i)[0]);
            _presets[_preset].buttons_long[i].number  = settings.getButtonLong(_preset, i)[1];
            _presets[_preset].buttons_long[i].channel = settings.getButtonLong(_preset, i)[2];
        } 
    }

}

void ControlsManager::onControlChange(uint8_t channel, uint8_t control, uint8_t value) {
    // Serial.print("Control Change - Channel: ");
    // Serial.print(channel);
    // Serial.print(", Control: ");
    // Serial.print(control);
    // Serial.print(", Value: ");
    // Serial.println(value);
    
    for (int i = 0; i < 8; ++i) {
        if (_presets[_currentPreset].encoder[i].channel == channel &&
            _presets[_currentPreset].encoder[i].number == control) {
            // Call the encoder change handler
            // onEncoderChange(i, value);
            if(_presets[_currentPreset].encoder[i].value == value) faders[i]->showParamName();
            faders[i]->setValue(value);
            setEncoderValue(i, value);
            encoders.positions[i] = value; // Met à jour la position de l'encodeur
            // _presets[_currentPreset].encoder[i].value == value;
            return;
        }
    }
}