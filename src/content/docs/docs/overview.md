---
title: Overview
description: What is param8 and what can it do
---

**param8** is a compact USB MIDI controller built around 8 push-encoders, 8 buttons, and two high-resolution OLED displays. It connects via USB-C as a class-compliant MIDI device and ships with a dedicated Ableton Live remote script for deep integration.

## Hardware

- **8 rotary encoders** with push-button — infinite rotation, no end stops
- **8 tactile buttons** — momentary or toggle mode
- **2 × SSD1322 OLED displays** — 256×64 pixels each, showing parameter names, values, and visual indicators
- **Raspberry Pi Pico (RP2040)** — dual-core ARM Cortex-M0+ at 133 MHz
- **USB-C** — bus-powered, class-compliant USB MIDI

## Software

- **6 user presets** — fully configurable CC/Note assignments per encoder and button
- **Mixer mode** (preset 7) — master volume, cue, tempo, scene select, track volume/pan, and more
- **Device mode** (preset 8) — automatic bank navigation for the selected Ableton device
- **Latch mode** — queue encoder changes and release them simultaneously
- **Revert mode** — undo encoder movements
- **Web editor** — configure everything from your browser via WebMIDI
- **3 display layouts** — Dynamic, Compact, and Stacked

## Architecture

```
┌──────────┐     USB MIDI      ┌──────────────┐
│  param8  │ ◄──────────────► │ Ableton Live │
│ firmware │                   │ Remote Script│
└──────────┘                   └──────────────┘
      ▲                              
      │ WebMIDI / Serial             
      ▼                              
┌──────────┐                         
│  Editor  │                         
│  (Web)   │                         
└──────────┘                         
```
