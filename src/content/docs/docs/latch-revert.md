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

## Revert Mode

Revert lets you undo your recent encoder movements.

1. **Hold Shift + press Latch** to enter Revert mode (LED blinks)
2. **Turn encoders** — movements are recorded
3. **Press Latch** to revert — all recorded movements are played back in reverse
4. **Press Shift** to exit Revert mode without reverting
