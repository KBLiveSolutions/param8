---
title: Latch & Revert
description: Queue and undo encoder changes
---

## Latch Mode

Latch lets you prepare encoder changes without sending them, then release everything at once.

1. **Hold the Latch button** (left button) — LED turns on after 300ms
2. **Turn any encoders** — changes are queued, not sent
3. **Release Latch** — all queued changes are sent simultaneously, interleaved across encoders for smooth playback

This is useful for preparing multiple parameter changes and committing them at the same moment.

### Absolute vs Relative

- **Relative encoders:** Each individual delta is stored and replayed in order
- **Absolute encoders:** Only the final value is sent on release

## Revert Mode

Revert lets you undo your recent encoder movements.

1. **Hold Shift + press Latch** to enter Revert mode (LED blinks)
2. **Turn encoders** — movements are recorded
3. **Hold Shift + press Latch again** to revert — all recorded movements are played back in reverse
4. **Press Latch alone** to exit Revert mode without reverting

## Double-Tap Latch

Double-tapping the Latch button (two presses within 300ms) sends a name request to the remote script for the last-used control. The name is then stored in the current preset.
