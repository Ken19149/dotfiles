#!/bin/bash
STATE_FILE="/tmp/ocr_mode"

# Switch the state
if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" == "JP" ]; then
    echo "CN" > "$STATE_FILE"
else
    echo "JP" > "$STATE_FILE"
fi

# Send Signal 8 to Waybar to instantly update the UI
pkill -RTMIN+8 waybar
