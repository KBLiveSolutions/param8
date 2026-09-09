---
title: Device Mode
description: Automatic device parameter control (Preset 8)
---

Preset 8 (**Device**) maps the 8 encoders to parameters of the currently selected device in Ableton Live. The remote script handles bank switching and parameter naming automatically.

The left header shows the device name, the right header shows the bank name.

## Encoders

The 8 encoders map to the current bank of 8 parameters from the selected device. Parameter names and values are displayed on the OLEDs in real time.

## Buttons

| 1 | 2 | 3 | 4 |
|:---:|:---:|:---:|:---:|
| Prev Track | Next Track | Device On | A/B |
| **5** | **6** | **7** | **8** |
| Prev Device | Next Device | Prev Bank | Next Bank |

A/B toggles the compare A/B function in Ableton Live, available only for Live's native devices (excluding Racks).

## Bank Resolution

The remote script uses Ableton's banking info to organize parameters into banks of 8. For instruments with incomplete bank definitions (like AAS Tension or Collision), empty slots are automatically filled with spare device parameters.

## Parameter Watchers

When a parameter has an active watcher from the remote script, its display shows the value received from Live rather than the raw encoder position. This keeps the display in sync with the actual parameter state.
