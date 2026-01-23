#pragma once
#include "LittleFS.h"
#include <ArduinoJson.h>


class SettingsJsonManager {
public:
    SettingsJsonManager(const char* path = "data/data.json");

    bool load();
    bool save();

    int getMode();
    void setMode(int mode);

    JsonObject getPreset(uint8_t idx);

    JsonArray getButtonShort(uint8_t preset, uint8_t btn);
    void setButtonShort(uint8_t preset, uint8_t btn, int v0, int v1);

    JsonArray getButtonLong(uint8_t preset, uint8_t btn);
    void setButtonLong(uint8_t preset, uint8_t btn, int v0, int v1);

    JsonArray getEncoder(uint8_t preset, uint8_t enc);
    void setEncoder(uint8_t preset, uint8_t enc, int v0, int v1);

private:
    const char* _path;
    StaticJsonDocument<4096> _doc;
};
void setupJsonManager();
extern SettingsJsonManager settings;