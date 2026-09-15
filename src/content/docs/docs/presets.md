---
title: Presets
description: Configuring and switching presets
---

param8 has **8 presets** total: 6 user-configurable presets and 2 built-in modes.

## Switching Presets

Hold **Shift** to see preset names on the displays, then press any of the 8 buttons:

| Button | Preset |
|--------|--------|
| 1–6 | User presets |
| 7 | Mixer / Global mode |
| 8 | Device mode |

The current preset is highlighted when Shift is held.

Presets can also be changed remotely by sending Program Change messages to the controller (any Channel).

## User Presets (1–6)

Each user preset stores independent settings for all 8 encoders and 8 buttons:

- **Encoders:** MIDI CC number, channel, custom name
- **Buttons:** MIDI CC or Note, number, channel, toggle/momentary mode, custom name
- **Preset name:** shown in the display header

## Configuring Presets

Use the [web editor](/editor/) or assign names directly from Ableton using the double-tap latch gesture.

### From the Editor
1. Connect param8 via USB
2. Open the editor in Chrome
3. Select a preset tab
4. Configure each encoder and button

### From Ableton Live

#### Automatic naming + values
1. Select a parameter in your DAW
2. Turn or Push the control you want to rename
3. Double-tap the Latch button on param8
4. The parameter's name is sent from the remote script and stored in the preset. The control will show the value as shown in Ableton Live

To cancel the linking, double-tap the Latch button and hold the button on the second tap. The control name and value will revert to the standard MIDI message.

#### Per set controls naming
You can use Racks to have different control names for each Live set.
1. Add a Rack on a Track (MIDI, Audio or Instrument Rack)
2. Rename it like that : "param8 N" with N being the preset number
3. Rename the Macros. Macros 1-8 will rename Encoders 1-8, Macros 9-16 with rename Buttons 1-8

Here is an example of Controls 1 to 5 being renamed for Preset 1

![Rename with Rack](/images/RackRenamer.webp "Rename with Rack")

#### Dynamic naming
If your mappings change during a performance and you want the name the control to follow the curent mapping, you can use Racks chains.
1. Add a Rack on a Track (MIDI, Audio or Instrument Rack)
2. Rename it like that : "param8 N" with N being the preset number
3. Add as many chains as you want names
4. Add a Rack on each chain and rename its macros
5. Set or automate the Chain Selector to have a specific Chain actibe

Here is an example of Controls 1 to 5 being renamed for Preset 1 with Chain 3 active

![Rename with Rack](/images/MultiRackRenamer.webp "Rename with Rack")
