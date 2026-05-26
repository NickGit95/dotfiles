-- Input configuration for keyboard, mouse and tablet
hl.config({
    input = {
        kb_layout = "latam",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 50,
        repeat_delay = 300,

        follow_mouse = 1,
        mouse_refocus = false,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
        tablet = {
            output = "DP-1",
            region_position = { 15, 50 },
            region_size = { 2530, 1375 },
        },
    },
})
