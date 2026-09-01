---
title: SysEx Protocol
description: System Exclusive message reference
---

param8 uses SysEx messages for communication between the firmware, remote script, and editor. All messages use manufacturer byte `0x6F`.

## Message Format

```
F0 6F <status> <data...> F7
```

## Status Bytes

### From Host → Controller

| Status | Name | Format | Description |
|--------|------|--------|-------------|
| `0x00` | Param Name | `F0 6F 00 <idx> <static> <ascii...> F7` | Set parameter name for encoder (idx 0–7) or button (idx 8–15) |
| `0x01` | Param Value | `F0 6F 01 <idx> <static> <ascii...> F7` | Set value display text for encoder idx |
| `0x02` | Bank Label | `F0 6F 02 00 00 <ascii...> F7` | Set bank label (right header) |
| `0x03` | Device Label | `F0 6F 03 00 00 <ascii...> F7` | Set device label (left header) |
| `0x05` | Handshake | `F0 6F 05 F7` | Connection handshake from remote script |
| `0x07` | Request Controls | `F0 6F 07 <preset> F7` | Respond with all control configs for preset |
| `0x0C` | Set Encoder | `F0 6F 0C <preset> <idx> <type> <num> <ch> F7` | Configure encoder |
| `0x0D` | Set Button | `F0 6F 0D <preset> <idx> <type> <num> <ch> <toggle> F7` | Configure button |
| `0x0E` | Set Layout | `F0 6F 0E <layout> F7` | Set display layout (0/1/2) |
| `0x0F` | Set Control Name | `F0 6F 0F <preset> <idx> <isBtn> <ascii...> F7` | Store custom control name |
| `0x10` | Screen Saver | `F0 6F 10 <hi7> <lo7> F7` | Set screen saver timeout (seconds, 14-bit) |
| `0x11` | Preset Name | `F0 6F 11 <preset> <ascii...> F7` | Set preset name |
| `0x12` | Set Watcher | `F0 6F 12 <preset> <idx> <on> F7` | Enable/disable parameter watcher |

### From Controller → Host

| Status | Name | Format | Description |
|--------|------|--------|-------------|
| `0x04` | Preset Change | `F0 6F 04 <preset> F7` | Current preset notification |
| `0x0C` | Encoder Config | `F0 6F 0C <preset> <idx> <type> <num> <ch> F7` | Encoder configuration dump |
| `0x0D` | Button Config | `F0 6F 0D <preset> <idx> <type> <num> <ch> <toggle> F7` | Button configuration dump |
| `0x0E` | Layout Config | `F0 6F 0E <layout> F7` | Current layout |
| `0x0F` | Control Name | `F0 6F 0F <preset> <idx> <isBtn> <ascii...> F7` | Stored control name |
| `0x10` | Screen Saver Config | `F0 6F 10 <hi7> <lo7> F7` | Current screen saver timeout |
| `0x11` | Name Request | `F0 6F 11 <idx> <isBtn> <type> <num> <ch> F7` | Request control name from remote script |

## ASCII Encoding

Text in SysEx uses a 2-byte encoding per character:

| Type byte | Value byte | Result |
|-----------|-----------|--------|
| `0x00` | `0x00–0x5E` | ASCII 32–126 (standard printable) |
| `0x01` | `0x00–0x7F` | Extended ASCII 128–255 |

## Control Types

| Value | Type |
|-------|------|
| `0` | CC (Control Change) |
| `1` | Note |
| `2` | Program Change |
