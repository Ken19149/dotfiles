#!/bin/bash
STATE_FILE="/tmp/ocr_mode"

if [ "$(cat "$STATE_FILE")" == "CN" ]; then
    # Chinese: Pure screenshot straight to PaddleOCR
    grim -g "$(slurp)" /tmp/paddle_capture.png
else
    # Japanese: Includes the ImageMagick negate trick for Genshin Impact!
    grim -g "$(slurp)" - | magick - -colorspace gray -auto-threshold otsu -negate /tmp/meiki_capture.png
fi
