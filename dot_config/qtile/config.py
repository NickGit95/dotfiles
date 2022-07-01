"""
   ___ _____ ___ _     _____
  / _ \_   _|_ _| |   | ____|
 | | | || |  | || |   |  _|
 | |_| || |  | || |___| |___
  \__\_\|_| |___|_____|_____|
"""

import subprocess
from libqtile import layout, hook
from libqtile.config import Match
from groups import init_groups
from inputs import init_group_keys, init_regular_keys, init_mouse_inputs
from screens import init_screens
from layouts import init_layouts
import variables


keys = init_regular_keys()

groups = init_groups()

keys.extend(init_group_keys())

mouse = init_mouse_inputs()

layouts = init_layouts()

widget_defaults = dict(
    background=variables.COLORS["background"],
    foreground=variables.COLORS["foreground"],
    font=variables.FONT,
    fontsize=variables.FONT_SIZE,
)
extension_defaults = widget_defaults.copy()

screens = init_screens()

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=[variables.COLORS["purple"]],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    """Autostart script"""
    subprocess.call([variables.AUTO_START])
