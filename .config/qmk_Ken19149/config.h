#pragma once

// 1. Tapping Term for Mod-Taps and Tap Dance (ms)
#define TAPPING_TERM 160

// 2. Prevent fast overlapping alpha rolls from accidentally becoming modifiers
// (Essential for fast Colemak-DH typing)
#undef PERMISSIVE_HOLD
#define HOLD_ON_OTHER_KEY_PRESS_PER_KEY

// 3. Streak protection for Achordion
#define ACHORDION_STREAK

// 4. Quick tap term: prevents double-tapping a mod-tap from repeating the hold
#define QUICK_TAP_TERM 0

// 5. Window for chording Combos (W+F, F+P, R+S, etc.)
#define COMBO_TERM 25
