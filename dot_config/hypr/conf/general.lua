-- General configs, colors and decoration
local colors = require("conf.colors")
local foreground = colors.foreground
local color_1 = colors.color_1

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 2,
        col = {
            active_border = color_1,
            inactive_border = foreground,
        },
        layout = "master",
        allow_tearing = false,
    },

    decoration = {
        rounding = 10,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation configs
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 80%" })
