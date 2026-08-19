-- ~/.config/hypr/hyprland.lua
-- local hl = require("hyprland")

-- 1. Variables
local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "thunar"

-- 2. General Configuration & Monitors
hl.config({
    monitor = {
        "eDP-2,2560x1600@240.00Hz, 0x0, 1.6",
        "HDMI-A-1, 1920x1080@60.00Hz, 1600x0, 1"
    },
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        -- Note: Lua requires brackets for keys with periods in them
        ["col.active_border"] = { colors = {"rgba(90C4FEEE)", "rgba(FFB8D2EE)"}, angle = 45 },
        ["col.inactive_border"] = "rgba(565F89AA)",
        resize_on_border = false,
        layout = "dwindle"
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        blur = { enabled = true, size = 3 }
    },

    env = {
        "XCURSOR_SIZE,24",
        "HYPRCURSOR_SIZE,24",
        "LIBVA_DRIVER_NAME,nvidia",
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = false }
    },
    dwindle = { preserve_split = true },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = "0x000000"
    },
    animations = {
        enabled = true,
        bezier = {
            "easeOutQuint, 0.23, 1, 0.32, 1",
            "easeInOutCubic, 0.65, 0.05, 0.36, 1",
            "linear, 0, 0, 1, 1",
            "almostLinear, 0.5, 0.5, 0.75, 1",
            "quick, 0.15, 0, 0.1, 1"
        },
        animation = {
            "global, 1, 10, default",
            "border, 1, 5.39, easeOutQuint",
            "windows, 1, 4.79, easeOutQuint",
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%",
            "windowsOut, 1, 1.49, linear, popin 87%",
            "fadeIn, 1, 1.73, almostLinear",
            "fadeOut, 1, 1.46, almostLinear",
            "fade, 1, 3.03, quick",
            "workspaces, 1, 1.94, almostLinear, fade"
        }
    }
})

-- 3. Autostart (Exec-Once)
hl.on("hyprland.start", function ()
    local autostart = {
        "hyprpm reload -n & otd-daemon & fcitx5 & wayscriber --daemon",
        "waybar & sleep 0.5 && killall -SIGUSR1 waybar",
        "[workspace 1 silent] zen-browser",
        "[workspace 2 silent] ~/.config/hypr/scripts/launch_main.sh",
        "sleep 2 && hyprctl dispatch workspace 4"
    }

    for _, cmd in ipairs(autostart) do
        hl.exec_cmd(cmd)
    end
end)

-- 4. Keybinds
-- Notice how we can use standard Lua string concatenation (..) for the tmux command
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal .. " -e tmux new -A"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Colemak-DH friendly screenshot binds
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/active_window_shot.sh"))

-- Dynamically generate binds for workspaces 1 through 9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Map the "0" key to workspace 10 separately
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scroll Workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Maximize Suppress Rule
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Directional Focus (Arrow Keys)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))

-- Swap window position directionally
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))

-- XWayland Ghost Window Fix
hl.window_rule({
    match = { 
        class = "^$", 
        title = "^$", 
        xwayland = true, 
        float = true, 
        fullscreen = false, 
        pin = false 
    },
    no_initial_focus = 1
})

-- 5. Window Rules (LMMS example)
hl.window_rule({ 
    match = { class = "^lmms$" }, 
    opacity = "1.0 override 1.0 override 1.0 override", 
    no_blur = 1 
})
