#pragma once

// 1. How long (ms) to hold a key for it to become Shift/Ctrl/etc.
// Start with 200. If you type fast and get accidental mods, lower it to 160.
#define TAPPING_TERM 160

// 2. Makes modifiers trigger faster when typing chords (essential for home row mods)
#define PERMISSIVE_HOLD

// 3. Prevents "st" from becoming "Shift" when typing fast repeated letters
#define QUICK_TAP_TERM 0

// 4. Reduces the window (in ms) where two keys count as a combo.
// Default is 50ms. Dropping to 25-30ms filters out fast typing rolls.
#define COMBO_TERM 25
