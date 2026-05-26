-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

-- local suppressMaximizeRule = hl.window_rule({
--     -- Ignore maximize requests from all apps. You'll probably like this.
--     name = "suppress-maximize-events",
--     match = { class = ".*" },
--
--     suppress_event = "maximize",
-- })
-- -- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.window_rule({
    -- Dialogs
    name = "Dialogs",
    match = {
        class = "org.freedesktop.impl.portal.desktop.kde",
    },

    float = true,
})

hl.window_rule({
    -- Float mpv videos
    name = "mpv",
    match = {
        class = "mpv",
    },

    float = true,
})

hl.window_rule({
    -- Steam and games rules
    name = "steam",
    match = {
        class = "steam.*",
    },

    rounding = 0,
    float = true,
    workspace = 3,
})

hl.window_rule({
    -- Retroarch special rules
    name = "RetroArch",
    match = {
        class = "com.libretro.RetroArch",
    },

    idle_inhibit = "always",
    workspace = 3,
})

hl.window_rule({
    -- Brave only on workspace 1
    name = "Brave",
    match = {
        class = "[bB]rave-browser",
    },

    workspace = 1,
})

hl.window_rule({
    name = "LibreWolf",
    match = {
        class = "LibreWolf",
    },

    workspace = 1,
})

hl.window_rule({ match = { title = "^(Steam Big Picture Mode)" }, fullscreen = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "blueberry.py" }, float = true })
hl.window_rule({ match = { class = "org.kde.kcalc" }, float = true })
hl.window_rule({ match = { class = ".*.exe" }, float = true })
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
