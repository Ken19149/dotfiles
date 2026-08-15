#!/bin/bash

# Define your monitor name (must match hyprpaper.conf)
MONITOR="HDMI-A-1"

# Function to handle workspace changes
handle_workspace() {
    case $1 in
        11) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-1.png" ;;
        12) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-2.png" ;;
        13) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-3.png" ;;
        14) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-4.png" ;;
        15) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-5.png" ;;
        16) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-6.png" ;;
        17) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-7.png" ;;
        18) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-8.png" ;;
        19) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-9.png" ;;
        20) WALLPAPER="/home/ken/Pictures/wallpapers/perfect-blue-10.png" ;;
        *) return ;; # Do nothing for other workspaces
    esac

    # Command hyprpaper to switch. Since images are preloaded, this is instant.
    hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
}

# Listen to the Hyprland socket for events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ $line =~ ^workspace\>\>(.*) ]]; then
        # $BASH_REMATCH[1] contains the new workspace ID
        handle_workspace "${BASH_REMATCH[1]}"
    fi
done
