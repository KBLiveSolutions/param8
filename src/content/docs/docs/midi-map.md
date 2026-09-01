---
title: MIDI Map
description: Default CC and channel assignments
---

## Default Encoder Mapping

All user presets (1–6) default to relative CC on channel 1.

| Encoder | Preset 1 | Preset 2 | Preset 3 | Preset 4 | Preset 5 | Preset 6 |
|---------|----------|----------|----------|----------|----------|----------|
| 1 | CC 0 | CC 8 | CC 16 | CC 24 | CC 32 | CC 40 |
| 2 | CC 1 | CC 9 | CC 17 | CC 25 | CC 33 | CC 41 |
| 3 | CC 2 | CC 10 | CC 18 | CC 26 | CC 34 | CC 42 |
| 4 | CC 3 | CC 11 | CC 19 | CC 27 | CC 35 | CC 43 |
| 5 | CC 4 | CC 12 | CC 20 | CC 28 | CC 36 | CC 44 |
| 6 | CC 5 | CC 13 | CC 21 | CC 29 | CC 37 | CC 45 |
| 7 | CC 6 | CC 14 | CC 22 | CC 30 | CC 38 | CC 46 |
| 8 | CC 7 | CC 15 | CC 23 | CC 31 | CC 39 | CC 47 |

## Default Button Mapping

All user presets default to Note mode on channel 1.

| Button | Preset 1 | Preset 2 | Preset 3 | Preset 4 | Preset 5 | Preset 6 |
|--------|----------|----------|----------|----------|----------|----------|
| 1 | Note 0 | Note 8 | Note 16 | Note 24 | Note 32 | Note 40 |
| 2 | Note 1 | Note 9 | Note 17 | Note 25 | Note 33 | Note 41 |
| 3 | Note 2 | Note 10 | Note 18 | Note 26 | Note 34 | Note 42 |
| 4 | Note 3 | Note 11 | Note 19 | Note 27 | Note 35 | Note 43 |
| 5 | Note 4 | Note 12 | Note 20 | Note 28 | Note 36 | Note 44 |
| 6 | Note 5 | Note 13 | Note 21 | Note 29 | Note 37 | Note 45 |
| 7 | Note 6 | Note 14 | Note 22 | Note 30 | Note 38 | Note 46 |
| 8 | Note 7 | Note 15 | Note 23 | Note 31 | Note 39 | Note 47 |

## Built-in Presets

Presets 7 (Mixer) and 8 (Device) use fixed CC assignments on channel 8. See the [Mixer Mode](/docs/mixer-mode/) and [Device Mode](/docs/device-mode/) pages for details.

## Relative Encoding

Encoders use **two's complement** relative encoding:
- `1–63` = clockwise (1 to 63 steps)
- `65–127` = counter-clockwise (1 to 63 steps)
- `64` = no change
