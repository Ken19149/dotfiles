/* Copyright 2021 @ Keychron (https://www.keychron.com)
 * Modified for Ken19149 Colemak-DH Minimalist Layout
 */

#include QMK_KEYBOARD_H
#include "achordion.h"

enum layers {
  MAC_BASE,
  WIN_BASE,
  WIN_GAMING,
  _NAV,
  _NUM,
  _SYM1, // Activated by holding Caps Lock + Spacebar (Tri-Layer)
  _SYM2, // Activated by chording R + S
  _FN1,
  _FN2,
  _FN3
};

#define KC_TASK LGUI(KC_TAB)
#define KC_FLXP LGUI(KC_E)

// ==========================================
// 1. TAP DANCE DEFINITIONS
// Single tap: ' (Quote) | Double tap: ` (Backtick)
// ==========================================
enum {
  TD_QUOT_GRV,
};

tap_dance_action_t tap_dance_actions[] = {
    [TD_QUOT_GRV] = ACTION_TAP_DANCE_DOUBLE(KC_QUOT, KC_GRV),
};

// ==========================================
// 2. KEY OVERRIDES
// ==========================================
const key_override_t delete_override =
    ko_make_with_layers(MOD_MASK_SHIFT, KC_BSPC, KC_DEL, ~0);

const key_override_t redo_override =
    ko_make_with_layers(MOD_MASK_CS, KC_Z, LCTL(KC_Y), ~0);

const key_override_t *key_overrides[] = {&delete_override, &redo_override,
                                         NULL};

// ==========================================
// 3. COMBOS
// ==========================================
// Left Hand Combos
const uint16_t PROGMEM esc_combo[] = {KC_F, KC_P, COMBO_END}; // Esc
const uint16_t PROGMEM tab_combo[] = {KC_W, KC_F, COMBO_END}; // Tab
const uint16_t PROGMEM sym2_combo[] = {LALT_T(KC_R), LCTL_T(KC_S),
                                       COMBO_END}; // R + S -> _SYM2

// Right Hand Combos
const uint16_t PROGMEM bspc_combo[] = {KC_L, KC_U, COMBO_END}; // Backspace
const uint16_t PROGMEM ent_combo[] = {KC_U, KC_Y, COMBO_END};  // Enter

combo_t key_combos[] = {
    COMBO(esc_combo, KC_ESC),     COMBO(tab_combo, KC_TAB),
    COMBO(sym2_combo, MO(_SYM2)), COMBO(bspc_combo, KC_BSPC),
    COMBO(ent_combo, KC_ENT),
};

// ==========================================
// 4. KEYMAP MATRIX
// ==========================================
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    /* MAC_BASE (Unchanged) */
    [MAC_BASE] = LAYOUT_60_ansi(
        KC_ESC, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0,
        KC_MINS, KC_EQL, KC_BSPC, KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y,
        KC_U, KC_I, KC_O, KC_P, KC_LBRC, KC_RBRC, KC_BSLS, KC_CAPS, KC_A, KC_S,
        KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT, KC_ENT,
        KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT,
        KC_SLSH, KC_RSFT, KC_LCTL, KC_LOPT, KC_LCMD, KC_SPC, KC_RCMD, MO(_FN1),
        MO(_FN3), KC_RCTL),

    /* WIN_BASE (Colemak-DH + Homerow Mods + Spacebar Nav + CapsLock Num +
       TapDance Quote/Backtick) */
    [WIN_BASE] = LAYOUT_60_ansi(
        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, KC_NO, KC_NO, CW_TOGG, KC_NO, KC_Q, KC_W, KC_F, KC_P, KC_B, KC_J,
        KC_L, KC_U, KC_Y, KC_SCLN, KC_LBRC, KC_RBRC, KC_BSLS, MO(_NUM),
        LGUI_T(KC_A), LALT_T(KC_R), LCTL_T(KC_S), LSFT_T(KC_T), KC_G, KC_M,
        RSFT_T(KC_N), RCTL_T(KC_E), RALT_T(KC_I), RGUI_T(KC_O), TD(TD_QUOT_GRV),
        KC_NO, KC_LSFT, KC_X, KC_C, KC_D, KC_V, KC_Z, KC_K, KC_H, KC_COMM,
        KC_DOT, KC_SLSH, TG(WIN_GAMING), KC_LCTL, KC_LWIN, KC_LALT,
        LT(_NAV, KC_SPC), KC_RALT, MO(_FN2), MO(_FN3), KC_RCTL),

    /* _NAV (Spacebar held) */
    [_NAV] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, KC_F1, KC_F2, KC_F3, KC_F4,
        _______, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______),

    /* _NUM (Caps Lock held: 0-3 on Home, 4-6 Top, 7-9 Bottom, Math surrounding)
     */
    [_NUM] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, KC_NO, KC_4, KC_5, KC_6, KC_MINS,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, KC_0, KC_1, KC_2, KC_3, KC_EQL, KC_PLUS, _______, _______,
        _______, _______, _______, _______, _______, KC_ASTR, KC_7, KC_8, KC_9,
        KC_BSLS, _______, _______, _______, _______, _______, _______, _______,
        _______, _______),

    /* _SYM1 (Caps Lock + Spacebar held: Enclosures [] {} () <> and structural
       syntax) */
    [_SYM1] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, KC_NO, KC_LBRC, KC_RBRC, KC_BSLS,
        KC_UNDS, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, KC_TILD, KC_LCBR, KC_LPRN, KC_RPRN, KC_RCBR, KC_COLN,
        _______, _______, _______, _______, _______, _______, _______, KC_NO,
        KC_LABK, KC_RABK, KC_QUES, KC_PIPE, _______, _______, _______, _______,
        _______, _______, _______, _______, _______),

    /* _SYM2 (R + S chorded: Vim & Shell operators anchored to Prime Home/Top
       keys) */
    [_SYM2] = LAYOUT_60_ansi(
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, KC_NO, KC_EXLM, KC_AT, KC_HASH,
        KC_NO, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, KC_UNDS, KC_DLR, KC_PERC, KC_CIRC, KC_AMPR, KC_NO,
        _______, _______, _______, _______, _______, _______, _______, KC_NO,
        KC_NO, KC_NO, KC_NO, KC_NO, _______, _______, _______, _______, _______,
        _______, _______, _______, _______),

    /* WIN_GAMING (QWERTY, No Homerow Mods, Swapped Caps/Backspace) */
    [WIN_GAMING] =
        LAYOUT_60_ansi(
            KC_ESC, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0,
            KC_MINS, KC_EQL, KC_CAPS, KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T,
            KC_Y, KC_U, KC_I, KC_O, KC_P, KC_LBRC, KC_RBRC, KC_BSLS, KC_BSPC,
            KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCLN,
            KC_QUOT, KC_ENT, KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M,
            KC_COMM, KC_DOT, KC_SLSH, TG(WIN_GAMING), KC_LCTL, KC_LWIN, KC_LALT,
            KC_SPC, KC_RALT, MO(_FN2), MO(_FN3), KC_RCTL),

    /* _FN1 (Unchanged) */
    [_FN1] = LAYOUT_60_ansi(
        KC_GRV, KC_BRID, KC_BRIU, KC_NO, KC_NO, RM_VALD, RM_VALU, KC_MPRV,
        KC_MPLY, KC_MNXT, KC_MUTE, KC_VOLD, KC_VOLU, RM_NEXT, RM_TOGG, RM_NEXT,
        RM_VALU, RM_HUEU, RM_SATU, RM_SPDU, _______, _______, _______, _______,
        KC_INS, KC_PGUP, KC_HOME, _______, _______, RM_PREV, RM_VALD, RM_HUED,
        RM_SATD, RM_SPDD, _______, _______, _______, _______, KC_PGDN, KC_END,
        _______, _______, _______, _______, _______, _______, _______, NK_TOGG,
        _______, _______, _______, KC_DEL, _______, _______, _______, _______,
        _______, _______, _______, _______, _______),

    /* _FN2 (Unchanged) */
    [_FN2] = LAYOUT_60_ansi(
        KC_GRV, KC_BRID, KC_BRIU, KC_TASK, KC_FLXP, RM_VALD, RM_VALU, KC_MPRV,
        KC_MPLY, KC_MNXT, KC_MUTE, KC_VOLD, KC_VOLU, RM_NEXT, RM_TOGG, RM_NEXT,
        RM_VALU, RM_HUEU, RM_SATU, RM_SPDU, _______, _______, KC_APP, KC_SCRL,
        KC_INS, KC_PGUP, KC_HOME, _______, _______, RM_PREV, RM_VALD, RM_HUED,
        RM_SATD, RM_SPDD, _______, _______, _______, _______, KC_PGDN, KC_END,
        _______, _______, _______, _______, _______, _______, _______, NK_TOGG,
        _______, _______, _______, KC_DEL, _______, _______, _______, _______,
        _______, _______, _______, _______, _______),

    /* _FN3 (Unchanged) */
    [_FN3] = LAYOUT_60_ansi(
        KC_TILD, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F6, KC_F7, KC_F8, KC_F9,
        KC_F10, KC_F11, KC_F12, QK_BOOT, RM_TOGG, RM_NEXT, RM_VALU, RM_HUEU,
        RM_SATU, RM_SPDU, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, RM_PREV, RM_VALD, RM_HUED, RM_SATD, RM_SPDD,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______)};

// =============================================
// 5. ACHORDION & TRI-LAYER LOGIC
// =============================================

// Run Achordion task every scan cycle
void matrix_scan_user(void) { achordion_task(); }

// Intercept events for Achordion processing
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (!process_achordion(keycode, record)) {
    return false;
  }
  return true;
}

// Direct hold resolution for layer keys vs home-row mods
bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case LT(_NAV, KC_SPC):
    return true; // Space Nav layer activates immediately when another key
                 // strikes
  default:
    return false; // Letters do NOT lock into mods on fast typing overlaps
  }
}

// Chord resolution rules
bool achordion_chord(uint16_t tap_hold_keycode, keyrecord_t *tap_hold_record,
                     uint16_t other_keycode, keyrecord_t *other_record) {

  // 1. Spacebar Nav layer always works immediately
  if (tap_hold_keycode == LT(_NAV, KC_SPC)) {
    return true;
  }

  // 2. Allow Shift keys (T and N) to chord with opposite hand immediately
  if (tap_hold_keycode == LSFT_T(KC_T) || tap_hold_keycode == RSFT_T(KC_N)) {
    return achordion_opposite_hands(tap_hold_record, other_record);
  }

  // 3. Strict opposite-hand rule for Home Row Mods (Ctrl, Alt, Gui)
  return achordion_opposite_hands(tap_hold_record, other_record);
}

// Tri-Layer: When Caps Lock (_NUM) AND Spacebar (_NAV) are held -> Activate
// _SYM1
layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _NUM, _NAV, _SYM1);
}

// =============================================
// 6. RGB MATRIX INDICATOR LOGIC
// =============================================

void keyboard_post_init_user(void) {
  rgb_matrix_mode_noeeprom(RGB_MATRIX_SOLID_COLOR);
  rgb_matrix_sethsv_noeeprom(0, 0, 40);
}

void set_indicator_color(uint8_t r, uint8_t g, uint8_t b) {
  for (int i = 0; i <= 13; i++) {
    rgb_matrix_set_color(i, r, g, b);
  }
  rgb_matrix_set_color(52, r, g, b); // Right Shift index
}

bool rgb_matrix_indicators_user(void) {
  if (IS_LAYER_ON(WIN_GAMING)) {
    set_indicator_color(0, 255, 0); // Green for Gaming
  } else if ((default_layer_state & (1UL << WIN_BASE)) ||
             IS_LAYER_ON(WIN_BASE)) {
    set_indicator_color(0, 255, 255); // Light Blue for Colemak-DH
  }
  return false;
}
