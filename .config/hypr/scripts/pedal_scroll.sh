#!/bin/bash

# Your specific piano port
MIDI_PORT="28:0"
SCROLL_PID=""

echo "Listening to piano pedal on port $MIDI_PORT..."

aseqdump -p "$MIDI_PORT" | while read -r line; do
    # Listen ONLY to Channel 0 to ignore the 4-channel echo
    if [[ "$line" == *"0, controller 64, value 127"* ]]; then
        if [ -z "$SCROLL_PID" ]; then
            # Start the scroll loop
            while true; do 
                sudo ydotool key 108:1 108:0 2>/dev/null
                sleep 0.1 
            done &
            
            SCROLL_PID=$!
        fi

    elif [[ "$line" == *"0, controller 64, value 0"* ]]; then
        if [ -n "$SCROLL_PID" ]; then
            # Kill the loop when pedal is released
            kill $SCROLL_PID
            SCROLL_PID=""
        fi
    fi
done
