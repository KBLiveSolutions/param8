---
title: Editor
description: Web-based configuration editor
---

The param8 editor is a browser-based tool that uses WebMIDI to configure the controller in real time.

## Requirements

- **Google Chrome** (or any Chromium-based browser with WebMIDI support)
- param8 connected via USB

## Access

- **Online:** [param8 Editor](/editor/)
- **Standalone:** Clone the [editor repo](https://github.com/KBLiveSolutions/param8-editor) and run `npm start`

## Features

### Preset Configuration
- Select any of the 6 user presets
- Set custom preset names
- Configure each encoder: CC number, MIDI channel
- Configure each button: CC or Note, number, channel, toggle/momentary mode

### Control Naming
- Set custom names for encoders and buttons
- Names are stored on the controller and persist across power cycles

### Display Settings
- Choose display layout: Dynamic, Compact, or Stacked
- Configure screen saver timeout

### Live Sync
All changes are sent to the controller immediately via SysEx and saved to flash.
