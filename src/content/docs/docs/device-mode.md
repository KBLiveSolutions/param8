---
title: Device Mode
description: Automatic device parameter control (Preset 8)
---

Preset 8 (**Device**) maps the 8 encoders to parameters of the currently selected device in Ableton Live. The remote script handles bank switching and parameter naming automatically.

## Encoders

The 8 encoders map to the current bank of 8 parameters from the selected device. Parameter names and values are displayed on the OLEDs in real time.

## Buttons

| # | Control |
|---|---------|
| 1 | Previous Track |
| 2 | Next Track |
| 3 | Hot-Swap mode |
| 4 | A/B toggle |
| 5 | Previous Device |
| 6 | Next Device |
| 7 | Previous Bank |
| 8 | Next Bank |

## Display

- **Left header:** Device name (shows the preset name if available, otherwise the class name)
- **Right header:** Bank name
- **Faders:** Parameter name and value for each of the 8 mapped parameters

## Bank Resolution

The remote script uses Ableton's banking info to organize parameters into banks of 8. For instruments with incomplete bank definitions (like AAS Tension or Collision), empty slots are automatically filled with spare device parameters.

## Parameter Watchers

When a parameter has an active watcher from the remote script, its display shows the value received from Live rather than the raw encoder position. This keeps the display in sync with the actual parameter state.
