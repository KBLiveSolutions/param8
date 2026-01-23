#include "core/settingsJsonManager.h"

SettingsJsonManager settings("/data.json");
SettingsJsonManager::SettingsJsonManager(const char* path)
    : _path(path) {}

bool SettingsJsonManager::load() {
    File file = LittleFS.open(_path, "r");
    Serial.printf("Loading settings from %s\n", _path);
    if (!file) {
        Serial.println("Failed to open settings file");
        return false;
    }
    Serial.println("Settings file opened successfully");
    DeserializationError error = deserializeJson(_doc, file);
    file.close();
    return !error;
}

bool SettingsJsonManager::save() {
    File file = LittleFS.open(_path, "w");
    if (!file) return false;
    bool ok = (serializeJsonPretty(_doc, file) > 0);
    file.close();
    return ok;
}

int SettingsJsonManager::getMode() {
    return _doc["mode"] | 0;
}

void SettingsJsonManager::setMode(int mode) {
    _doc["mode"] = mode;
}

JsonObject SettingsJsonManager::getPreset(uint8_t idx) {
    return _doc[String(idx)].as<JsonObject>();
}

JsonArray SettingsJsonManager::getButtonShort(uint8_t preset, uint8_t btn) {
    return _doc[String(preset)]["buttons_short"][String(btn)].as<JsonArray>();
}

void SettingsJsonManager::setButtonShort(uint8_t preset, uint8_t btn, int v0, int v1) {
    JsonArray arr = _doc[String(preset)]["buttons_short"][String(btn)].to<JsonArray>();
    arr[0] = v0;
    arr[1] = v1;
}

JsonArray SettingsJsonManager::getButtonLong(uint8_t preset, uint8_t btn) {
    return _doc[String(preset)]["buttons_long"][String(btn)].as<JsonArray>();
}

void SettingsJsonManager::setButtonLong(uint8_t preset, uint8_t btn, int v0, int v1) {
    JsonArray arr = _doc[String(preset)]["buttons_long"][String(btn)].to<JsonArray>();
    arr[0] = v0;
    arr[1] = v1;
}

JsonArray SettingsJsonManager::getEncoder(uint8_t preset, uint8_t enc) {
    return _doc[String(preset)]["encoders"][String(enc)].as<JsonArray>();
}

void SettingsJsonManager::setEncoder(uint8_t preset, uint8_t enc, int v0, int v1) {
    JsonArray arr = _doc[String(preset)]["encoders"][String(enc)].to<JsonArray>();
    arr[0] = v0;
    arr[1] = v1;
}

void setupJsonManager() {
    Serial.println("Initializing LittleFS...");
    if (!LittleFS.begin()) {
        Serial.println("Failed to mount LittleFS");
        return;
    }
    Serial.println("LittleFS mounted successfully");
    // File root = LittleFS.open("/");
    // File file = root.openNextFile();
    // while (file) {
    //     Serial.println(file.name());
    //     file = root.openNextFile();
    // }
    if (settings.load()) {
        int mode = settings.getMode();
        // ...
    }
}