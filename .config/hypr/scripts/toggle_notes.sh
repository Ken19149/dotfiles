#!/bin/bash

# 1. Check if the special:notes workspace is currently open
if ! hyprctl clients | grep -q "special:notes"; then
    # 2. Launch Ghostty, start/attach the 'notes' Tmux session, and instantly open today's note
    hyprctl dispatch exec "[workspace special:notes silent] ghostty -e tmux new -A -s notes 'nvim -c ObsidianToday'"

    # Give it a fraction of a second to render
    sleep 0.2
fi

# 3. Toggle the workspace in or out
hyprctl dispatch togglespecialworkspace notes
