-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

-- mod key
local main_mod = "SUPER"

--  Set programs that you use
local terminal = "kitty"
local file_manager = "pcmanfm-qt"
local menu = "fuzzel"

-- Directions
local directions = {
    left = { keybind = "H", resize = { x = "-10", y = "0" } },
    down = { keybind = "J", resize = { x = "0", y = "-10" } },
    up = { keybind = "K", resize = { x = "0", y = "10" } },
    right = { keybind = "L", resize = { x = "10", y = "0" } },
}

-- Main binds for terminal and closing
hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + X", hl.dsp.window.close({ window = "activewindow" }))

-- Open common apps
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd("ELECTRON_OZONE_PLATFORM_HINT=auto freetube"))
hl.bind(main_mod .. " + Z", hl.dsp.exec_cmd("hyprlock"))

-- Scripts
hl.bind(main_mod .. " + O", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshots.sh save"))
hl.bind(main_mod .. " + P", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/passfi.sh"))
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/login.sh"))
hl.bind(main_mod .. " + I", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/sound_output.py"))
hl.bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/passfi.sh OTP"))
hl.bind(main_mod .. " + SHIFT + O", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshots.sh clipboard"))

-- Volume and Media Control
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)

-- Move focus between monitors
hl.bind(main_mod .. " + W", hl.dsp.focus({ monitor = "0" }))
hl.bind(main_mod .. " + E", hl.dsp.focus({ monitor = "1" }))

-- Window movement and resizing
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))

for key, value in pairs(directions) do
    hl.bind(main_mod .. " + " .. value["keybind"], hl.dsp.focus({ direction = key }))
    hl.bind(main_mod .. " + SHIFT + " .. value["keybind"], hl.dsp.window.move({ direction = key }))
    hl.bind(
        main_mod .. " + CTRL + " .. value["keybind"],
        hl.dsp.window.resize({ x = value["resize"]["x"], y = value["resize"]["y"], relative = true }),
        { repeating = true }
    )
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
