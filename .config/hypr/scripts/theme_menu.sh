#!/bin/bash

# 1. Define your menu options
OPTIONS="Cinnamoroll\nSakura\nDark Mode"

# 2. Pipe them into your launcher to create a GUI menu (assuming wofi here)
# If you use rofi, change to: rofi -dmenu -p "Choose Theme:"
CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Choose Theme:")

# 3. Define the paths to your config files
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# 4. Execute changes based on what you clicked in the GUI
case "$CHOICE" in
    "Cinnamoroll")
        # Change Wallpaper
        swww img "$WALLPAPER_DIR/cinnamoroll.png" --transition-type grow
        # Change Ghostty Theme (swaps whatever theme is there with a pastel one)
        sed -i 's/^theme = .*/theme = "Catppuccin Frappe"/' "$GHOSTTY_CONFIG"
        ;;
    "Sakura")
        swww img "$WALLPAPER_DIR/sakura.png" --transition-type wipe
        sed -i 's/^theme = .*/theme = "Rosé Pine Dawn"/' "$GHOSTTY_CONFIG"
        ;;
    "Dark Mode")
        swww img "$WALLPAPER_DIR/pure_black.png" --transition-type fade
        sed -i 's/^theme = .*/theme = "Tokyo Night"/' "$GHOSTTY_CONFIG"
        ;;
    *)
        # Do nothing if you press Escape or close the menu
        exit 0
        ;;
esac
