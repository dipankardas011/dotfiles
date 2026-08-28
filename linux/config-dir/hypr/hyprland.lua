-- Hyprland Lua config (migrated from hyprland.conf on 2026-08-23)
-- Ref: https://wiki.hypr.land/Configuring/Start/

------------------------
---- ENVIRONMENT ------
------------------------

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("XCURSOR_SIZE", "24")

------------------------
---- AUTOSTART --------
------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("dunst")
    hl.exec_cmd("solaar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("$HOME/.config/hypr/battery-warning.sh")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

------------------------
----  MONITORS  -------
------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-9",
    mode     = "3840x2160@120",
    position = "auto-left",
    scale    = 1.5,

    supports_wide_color = true,
    supports_hdr        = true,
    -- transform = 3

    -- bitdepth = 10         -- 10-bit color signaling (Dell U2725QE 10-bit panel)
    -- cm = hdredid          -- Uses Dell U2725QE EDID hardware HDR profile
    -- sdr_max_luminance = 203 -- Standard BT.2408 reference white for SDR content
    -- sdr_min_luminance = 0.005 -- IPS Black panel black level floor
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto-right",
    scale    = 1.6,

    supports_wide_color = true,
    supports_hdr        = true,
    -- bitdepth = 10       -- Crucial for HDR signaling
    -- cm = hdr            -- Options: hdr, hdredid, or auto
})

------------------------
---- RENDER / GPU ------
------------------------

hl.config({
    render = {
        direct_scanout = 1,
        cm_auto_hdr    = 1,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.config({
    opengl = {
        -- ADDED TO EXPERIMENT: helps with Nvidia screen flicker/black-frames (no-op on AMD/Intel)
        nvidia_anti_flicker = true,
    },
})

------------------------
----  MISC  -----------
------------------------

hl.config({
    misc = {
        disable_hyprland_guiutils_check = true,
        vrr                            = 1,
        force_default_wallpaper        = 0,
    },
})

------------------------
----  INPUT  ----------
------------------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.
        repeat_delay = 300,
        repeat_rate  = 50,

        touchpad = {
            natural_scroll = true,
        },
    },
})

------------------------
----  GENERAL  --------
------------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 0,

        layout = "dwindle",

        allow_tearing = false,
    },
})

hl.config({
    decoration = {
        rounding = 10,

        blur = {
            enabled           = true,
            size              = 5,
            passes            = 2,
            new_optimizations = true,
            ignore_opacity    = true,
        },
    },
})

------------------------
---- ANIMATIONS -------
------------------------

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.5, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, bezier = "default" })

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

------------------------
----  GESTURES  -------
------------------------

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

------------------------
----  MISC (debug) ----
------------------------

hl.config({
    debug = {
        vfr = 1,
    },
})

-----------------------
----  KEYBINDS  -----
-----------------------

local mainMod = "SUPER" -- Sets "Windows"/Super key as main modifier

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + i",       hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + f",       hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float())
hl.bind(mainMod .. " + d",       hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + c",       hl.dsp.exec_cmd("$HOME/.config/hypr/cliphist-rofi.sh"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + h/j/k/l
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + q", hl.dsp.window.close())

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Screenshot manager
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.exec_cmd("bash -c 'grim -g \"$(slurp)\" - | $HOME/.cargo/bin/satty --filename -'"))

-- Reload config
hl.bind(mainMod .. " + SHIFT + r", hl.dsp.exec_cmd("hyprctl reload"))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0,  relative = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys (volume, mic, brightness)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/volume.sh \"UP\""),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/volume.sh \"DOWN\""), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("$HOME/.config/hypr/mute.sh \"mic\""),    { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("$HOME/.config/hypr/mute.sh \"volume\""), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("$HOME/.config/hypr/brightness.sh \"up\""),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("$HOME/.config/hypr/brightness.sh \"down\""), { locked = true, repeating = true })

-- Power menu
hl.bind(mainMod .. " + SHIFT + ALT + E", hl.dsp.exec_cmd("wlogout"))

---------------------------
---- WORKSPACE RULES  ----
---------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "1",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "2",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "3",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "4",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "5",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "6",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "7",  monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "9",  monitor = "DP-9" })
hl.workspace_rule({ workspace = "10", monitor = "DP-9" })
