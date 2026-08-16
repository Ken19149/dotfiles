/* Copyright 2021 @ Keychron (https://www.keychron.com
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "achordion.h"

// clang-format off

enum layers {
    MAC_BASE,
    WIN_BASE,
    WIN_GAMING,
    _NAV,
    _NUM,
    _FN1,
    _FN2,
    _FN3
};

#define KC_TASK LGUI(KC_TAB)
#define KC_FLXP LGUI(KC_E)

// ==========================================
// 1. KEY OVERRIDES (Shift+Backspace = Del, Ctrl+Shift+Z = Ctrl+Y)
// ==========================================
const key_override_t delete_override = ko_make_with_layers(
    MOD_MASK_SHIFT,
    KC_BSPC,        // The trigger key (which you mapped to physical Caps Lock)
    KC_DEL,         // The replacement
    ~0              // Active on all layers
);

const key_override_t redo_override = ko_make_with_layers(
    MOD_MASK_CS,    // Ctrl + Shift
    KC_Z,
    LCTL(KC_Y),     // Replacement: Ctrl + Y
    ~0
);

const key_override_t *key_overrides[] = {
    &delete_override,
    &redo_override,
    NULL
};

// ==========================================
// 2. COMBOS (Esc, Tab, Enter, Backspace)
// ==========================================
// Left Hand Combos
const uint16_t PROGMEM esc_combo[] = {KC_F, KC_P, COMBO_END}; // Colemak F+P (Index + Middle)
const uint16_t PROGMEM tab_combo[] = {KC_W, KC_F, COMBO_END}; // Colemak W+F (Middle + Ring)

// Right Hand Combos
const uint16_t PROGMEM bspc_combo[] = {KC_L, KC_U, COMBO_END}; // QWERTY U+I (Index + Middle)
const uint16_t PROGMEM ent_combo[]  = {KC_U, KC_Y, COMBO_END}; // QWERTY I+O (Middle + Ring)

combo_t key_combos[] = {
    COMBO(esc_combo, KC_ESC),
    COMBO(tab_combo, KC_TAB),
    COMBO(bspc_combo, KC_BSPC),
    COMBO(ent_combo, KC_ENT),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    /* MAC_BASE (Unchanged) */
    [MAC_BASE] = LAYOUT_60_ansi(
        KC_ESC,  KC_1,     KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,     KC_MINS,  KC_EQL,   KC_BSPC,
        KC_TAB,  KC_Q,     KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,     KC_LBRC,  KC_RBRC,  KC_BSLS,
        KC_CAPS, KC_A,     KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,  KC_QUOT,            KC_ENT,
        KC_LSFT,           KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_SLSH,            KC_RSFT,
        KC_LCTL, KC_LOPT,  KC_LCMD,                               KC_SPC,                                       KC_RCMD,  MO(_FN1), MO(_FN3), KC_RCTL),

    /* WIN_BASE (Colemak-DH + Homerow Mods + Spacebar Nav + CapsLock Num) */
    [WIN_BASE] = LAYOUT_60_ansi(
        KC_NO,   KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,     KC_MINS,  KC_EQL,  CW_TOGG,
        KC_NO,  KC_Q,    KC_W,    KC_F,    KC_P,    KC_B,    KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,  KC_LBRC,  KC_RBRC,  KC_BSLS,
        MO(_NUM),   LGUI_T(KC_A), LALT_T(KC_R), LCTL_T(KC_S), LSFT_T(KC_T), KC_G,    KC_M,    RSFT_T(KC_N), RCTL_T(KC_E), RALT_T(KC_I), RGUI_T(KC_O),     KC_QUOT,            KC_NO,
        KC_LSFT,          KC_X,    KC_C,    KC_D,    KC_V,    KC_Z,    KC_K,    KC_H,    KC_COMM, KC_DOT,   KC_SLSH,            TG(WIN_GAMING),
        KC_LCTL, KC_LWIN, KC_LALT,                                LT(_NAV, KC_SPC),                                     KC_RALT,  MO(_FN2), MO(_FN3), KC_RCTL),

    [_NAV] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        // The M N E I positions are converted to Arrow Keys
        _______, _______, _______, _______, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT,_______, _______,          _______,
        _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______,
        _______, _______, _______,                               _______,                                     _______, _______, _______, _______),

    /* _NUM (Number Layer: Hold Caplock to activate) */
    [_NUM] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, KC_1,    KC_2,    KC_3,    KC_MINS, _______, _______, _______,
        _______, KC_LBRC, KC_RBRC, KC_QUOT, _______, _______, _______, KC_4,    KC_5,    KC_6,    KC_0,    KC_EQL,           _______,
        _______,          _______, _______, _______, _______, _______, _______, KC_7,    KC_8,    KC_9,    KC_SLSH,          _______,
        _______, _______, _______,                               _______,                                     _______, _______, _______, _______),

    /* WIN_GAMING (QWERTY, No Homerow Mods, Swapped Caps/Backspace) */
    [WIN_GAMING] = LAYOUT_60_ansi(
        KC_ESC,  KC_1,     KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,     KC_MINS,  KC_EQL,   KC_CAPS, // Backspace position acts as Caps Lock
        KC_TAB,  KC_Q,     KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,     KC_LBRC,  KC_RBRC,  KC_BSLS,
        KC_BSPC, KC_A,     KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,  KC_QUOT,            KC_ENT,  // Caps Lock position acts as Backspace
        KC_LSFT,           KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_SLSH,            TG(WIN_GAMING), // Press again to return to Normal Mode
        KC_LCTL, KC_LWIN,  KC_LALT,                               KC_SPC,                                       KC_RALT,  MO(_FN2), MO(_FN3), KC_RCTL),

    /* _FN1 (Unchanged) */
    [_FN1] = LAYOUT_60_ansi(
        KC_GRV,  KC_BRID,  KC_BRIU, KC_NO,   KC_NO,   RM_VALD, RM_VALU, KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE,  KC_VOLD,  KC_VOLU,  RM_NEXT,
        RM_TOGG, RM_NEXT,  RM_VALU, RM_HUEU, RM_SATU, RM_SPDU, _______, _______, _______, _______, KC_INS,   KC_PGUP,  KC_HOME,  _______,
        _______, RM_PREV,  RM_VALD, RM_HUED, RM_SATD, RM_SPDD, _______, _______, _______, _______, KC_PGDN,  KC_END,             _______,
        _______,           _______, _______, _______, _______, _______, NK_TOGG, _______, _______, _______,  KC_DEL,             _______,
        _______, _______,  _______,                               _______,                                       _______,  _______,  _______,  _______),

    /* _FN2 (Unchanged) */
    [_FN2] = LAYOUT_60_ansi(
        KC_GRV,  KC_BRID,  KC_BRIU, KC_TASK, KC_FLXP, RM_VALD, RM_VALU, KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE,  KC_VOLD,  KC_VOLU,  RM_NEXT,
        RM_TOGG, RM_NEXT,  RM_VALU, RM_HUEU, RM_SATU, RM_SPDU, _______, _______, KC_APP,  KC_SCRL, KC_INS,   KC_PGUP,  KC_HOME,  _______,
        _______, RM_PREV,  RM_VALD, RM_HUED, RM_SATD, RM_SPDD, _______, _______, _______, _______, KC_PGDN,  KC_END,             _______,
        _______,           _______, _______, _______, _______, _______, NK_TOGG, _______, _______, _______,  KC_DEL,             _______,
        _______, _______,  _______,                               _______,                                       _______,  _______,  _______,  _______),

    /* _FN3 (Unchanged) */
    [_FN3] = LAYOUT_60_ansi(
        KC_TILD, KC_F1,    KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,   KC_F11,   KC_F12,   _______,
        RM_TOGG, RM_NEXT,  RM_VALU, RM_HUEU, RM_SATU, RM_SPDU, _______, _______, _______, _______, _______,  _______,  _______,  _______,
        _______, RM_PREV,  RM_VALD, RM_HUED, RM_SATD, RM_SPDD, _______, _______, _______, _______, _______,  _______,            _______,
        _______,           _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______,            _______,
        _______, _______,  _______,                               _______,                                       _______,  _______,  _______,  _______)
};

// =============================================
// PASTE THIS AT THE VERY BOTTOM OF keymap.c
// (After the closing }; of the keymaps array)
// =============================================

// 1. Run Achordion housekeeping every keyboard scan cycle
void matrix_scan_user(void) {
  achordion_task();
}

// 2. Intercept key presses to decide if they are Taps or Holds
bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  if (!process_achordion(keycode, record)) { return false; }
  return true;
}

// 3. (Optional but HIGHLY Recommended) Custom Behavior
// This makes sure Achordion doesn't accidentally block your Shift keys
// when you are typing really fast on the same hand.
bool achordion_chord(uint16_t tap_hold_keycode,
                     keyrecord_t* tap_hold_record,
                     uint16_t other_keycode,
                     keyrecord_t* other_record) {

  // Exception: Always allow Shift (T and N) to work immediately,
  // even if the next key is on the same hand.
  // This makes capitalizing words much smoother.
  if (tap_hold_keycode == LSFT_T(KC_T) || tap_hold_keycode == RSFT_T(KC_N)) {
    return true;
  }

  // Otherwise, use the "Opposite Hands" rule:
  // A mod only works if the next key is pressed with the OTHER hand.
  return achordion_opposite_hands(tap_hold_record, other_record);
}

// =============================================
// FINAL RGB CONFIGURATION (Top Row + Shift)
// Paste this at the very bottom of keymap.c
// =============================================

// 1. Startup Behavior
void keyboard_post_init_user(void) {
    rgb_matrix_mode_noeeprom(RGB_MATRIX_SOLID_COLOR);
    rgb_matrix_sethsv_noeeprom(0, 0, 40);   // (hue, sat, value)
}

// Helper function to color the Top Row (0-13) + Right Shift (52)
void set_indicator_color(uint8_t r, uint8_t g, uint8_t b) {
    // Light up the Top Row (Esc to Backspace)
    for (int i = 0; i <= 13; i++) {
        rgb_matrix_set_color(i, r, g, b);
    }
    // Light up Right Shift
    rgb_matrix_set_color(52, r, g, b);
}

// 2. Indicator Logic
bool rgb_matrix_indicators_user(void) {

    // PRIORITY 1: Check Gaming Layer (Layer 2)
    // We check IS_LAYER_ON because this is an overlay toggled by a key.
    if (IS_LAYER_ON(WIN_GAMING)) {
        // Light Green
        set_indicator_color(0, 255, 0);
    }

    // PRIORITY 2: Check Colemak Layer (Layer 1)
    // We check default_layer_state to see if the physical switch is set to Windows.
    // (We also check IS_LAYER_ON just in case you activated it via software).
    else if ((default_layer_state & (1UL << WIN_BASE)) || IS_LAYER_ON(WIN_BASE)) {
        // Light Blue
        set_indicator_color(0, 255, 255);
    }

    // If you are in Mac Mode (Layer 0), neither of these will be true,
    // and the lights will turn off (return to normal background).

    return false;
}
