-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@120.00Hz",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
    cm = "srgb",
    sdrsaturation = 1.2,
    sdrbrightness = 1.4,
    vrr = 3,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@72.04Hz",
    position = "2560x180",
    scale = 1,
    vrr = 3,
})
