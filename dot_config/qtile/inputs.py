"""Key configuration"""
import logging
from libqtile.config import Key, Drag, Click, KeyChord
from libqtile.command import lazy
import variables
from groups import init_groups


def init_group_keys():
    """Returns a list of group keybindings"""

    available_keys = list("123456789")
    keys = []
    for key, group in enumerate(init_groups()):
        if key < len(available_keys):
            keys.extend(
                [
                    Key(
                        [variables.MOD],
                        available_keys[key],
                        lazy.group[group.name].toscreen(),
                    ),
                    Key(
                        [variables.MOD, variables.SHIFT],
                        available_keys[key],
                        lazy.window.togroup(group.name),
                    ),
                ]
            )
        else:
            logging.info("groups to bind exceeds available keys")
    return keys


def init_regular_keys():
    """Returns a list of regular keys for window movement, open programs etc"""
    keys = [
        # Window movements
        Key([variables.MOD], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([variables.MOD], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([variables.MOD], "j", lazy.layout.down(), desc="Move focus down"),
        Key([variables.MOD], "k", lazy.layout.up(), desc="Move focus up"),
        Key(
            [variables.MOD],
            "space",
            lazy.layout.next(),
            desc="Move window focus to other window",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "j",
            lazy.layout.shuffle_down(),
            desc="Move window down",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "k",
            lazy.layout.shuffle_up(),
            desc="Move window up",
        ),
        # Window mode fullscreen/floating
        Key(
            [variables.MOD],
            "m",
            lazy.window.toggle_fullscreen(),
            desc="Toggle the window to/from fullscren",
        ),
        Key(
            [variables.MOD],
            "f",
            lazy.window.toggle_floating(),
            desc="Toggle the window to/from floating",
        ),
        # Window resize
        Key(
            [variables.MOD],
            "u",
            lazy.layout.grow(),
            desc="Grow current window",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "u",
            lazy.layout.shrink(),
            desc="Shrink current window",
        ),
        Key([variables.MOD], "n", lazy.layout.reset(), desc="Reset all window sizes"),
        # Split and layout control
        Key(
            [variables.MOD, variables.SHIFT],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key([variables.MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        # Launch and close apps
        Key(
            [variables.MOD],
            "Return",
            lazy.spawn(variables.TERMINAL),
            desc="Launch terminal",
        ),
        Key([variables.MOD], "r", lazy.spawn(variables.RUNNER), desc="Launch runner"),
        Key(
            [variables.MOD],
            "x",
            lazy.window.kill(),
            desc="Kill focused window",
        ),
        # App launch keychords
        KeyChord(
            [variables.MOD],
            "o",
            [
                Key([], "e", lazy.spawn(variables.EMACS), desc="Open emacs"),
                Key(
                    [],
                    "m",
                    lazy.spawn(variables.EMAIL),
                    desc="Open thunderbird",
                ),
                Key(
                    [],
                    "d",
                    lazy.spawn(variables.FILE_MANAGER),
                    desc="Open file manager",
                ),
                Key([], "b", lazy.spawn("brave"), desc="Open brave browser"),
                Key([], "w", lazy.spawn("librewolf"), desc="Open the wolf"),
            ],
        ),
        # Rofi keychords
        KeyChord(
            [variables.MOD],
            "p",
            [
                Key(
                    [],
                    "p",
                    lazy.spawn(variables.PASS_SCRIPT),
                    desc="Rofi script for password management",
                ),
                Key(
                    [],
                    "o",
                    lazy.spawn(variables.OTP_SCRIPT),
                    desc="Rofi script for OTP management",
                ),
                Key(
                    [],
                    "l",
                    lazy.spawn(variables.LOGIN_SCRIPT),
                    desc="Rofi script for logout options",
                ),
            ],
        ),
        # Screenshots
        KeyChord(
            [variables.MOD],
            "s",
            [
                Key(
                    [],
                    "s",
                    lazy.spawn(variables.SCREENSHOT_CLIP),
                    desc="Take a screenshot",
                ),
                Key(
                    [],
                    "v",
                    lazy.spawn(variables.SCREENSHOT),
                    desc="Take a screenshot and save it",
                ),
            ],
        ),
        # Screen movements
        Key([variables.MOD], "w", lazy.to_screen(0), desc="Moves to screen 0"),
        Key([variables.MOD], "e", lazy.to_screen(1), desc="Moves to screen 1"),
        # Screen lock
        Key(
            [variables.MOD],
            "z",
            lazy.spawn(variables.LOCKER),
            desc="Lock the screen",
        ),
        Key(
            [variables.MOD, variables.SHIFT],
            "z",
            lazy.spawn(variables.LOCKER_SUPER),
            desc="Suspends and lock the screen",
        ),
        # Sound
        Key(
            [],
            "XF86AudioMute",
            lazy.spawn(variables.VOLUME_MUTE),
            desc="Mute sound",
        ),
        Key(
            [],
            "XF86AudioRaiseVolume",
            lazy.spawn(variables.VOLUME_UP),
            desc="Increase volume by 5%",
        ),
        Key(
            [],
            "XF86AudioLowerVolume",
            lazy.spawn(variables.VOLUME_DOWN),
            desc="Decrease volume by 5%",
        ),
        # Qtile specific configs
        Key(
            [variables.MOD, variables.CONTROL],
            "r",
            lazy.reload_config(),
            desc="Reload the config",
        ),
        Key(
            [variables.MOD, variables.CONTROL],
            "q",
            lazy.shutdown(),
            desc="Shutdown Qtile",
        ),
    ]
    return keys


def init_mouse_inputs():
    """Returns a list of mouse inputs"""
    mouse = [
        Drag(
            [variables.MOD],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [variables.MOD],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([variables.MOD], "Button2", lazy.window.bring_to_front()),
    ]
    return mouse
