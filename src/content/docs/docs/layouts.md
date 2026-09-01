---
title: Display Layouts
description: The three display layout modes
---

param8 supports three display layouts, switchable via the editor or SysEx.

## Dynamic

The default layout. Each fader shows either the parameter name or the current value, switching automatically based on encoder activity:

- **Idle:** Shows the parameter name
- **Active:** Shows the numeric value (reverts to name after 500ms of inactivity)

A horizontal bar at the bottom indicates the current position.

## Compact

A three-column layout packing more information into each fader:

- **Left column:** Parameter name (right-aligned, wraps to 2 lines)
- **Center:** Knob arc indicator with needle
- **Right column:** Value text (left-aligned, wraps to 2 lines)

## Stacked

A vertical layout with all elements stacked:

1. Parameter name (centered)
2. Horizontal progress bar
3. Value text (centered)

## Switching Layouts

- From the **editor:** Select the layout in the display settings
- Via **SysEx:** Send `F0 6F 0E <layout> F7` where layout is `0` (Dynamic), `1` (Compact), or `2` (Stacked)

The selected layout is saved to flash and persists across power cycles.
