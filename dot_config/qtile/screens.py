"""Screen configuration"""
import os
import random
from libqtile import widget, bar
from libqtile.config import Screen
import variables

wallpaper_files = list(
    filter(
        lambda pape: ".png" in pape or "jpg" in pape,
        os.listdir(variables.WALLPAPER_DIR),
    )
)


def select_random_wallpaper():
    """Returns a random wallpaper"""
    wallpaper = random.choice(wallpaper_files)
    return variables.WALLPAPER_DIR + wallpaper


def init_widgets():
    """Returns a list of widgets in order"""
    widgets = [
        widget.Sep(
            linewidth=1,
            padding=6,
        ),
        widget.GroupBox(
            fontsize=20,
            margin_y=2,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=variables.COLORS["foreground-attention"],
            inactive=variables.COLORS["comment"],
            highlight_method="block",
            urgent_alert_method="block",
            this_current_screen_border=variables.COLORS["green"],
            this_screen_border=variables.COLORS["yellow"],
            other_current_screen_border=variables.COLORS["background"],
            other_screen_border=variables.COLORS["background"],
        ),
        widget.Sep(
            linewidth=1,
            padding=5,
        ),
        widget.WindowName(
            foreground=variables.COLORS["foreground-attention"],
            font="Ubuntu Bold",
            padding_y=5,
        ),
        widget.Sep(
            linewidth=0,
            padding=20,
        ),
        widget.TextBox(
            foreground=variables.COLORS["background"],
            background=variables.COLORS["orange"],
            fontsize=20,
            padding=5,
            text="",
        ),
        widget.CurrentLayout(
            foreground=variables.COLORS["orange"],
            padding=5,
        ),
        widget.Sep(
            linewidth=1,
            padding=20,
        ),
        widget.TextBox(
            foreground=variables.COLORS["background"],
            background=variables.COLORS["red"],
            fontsize=20,
            padding=5,
            text="",
        ),
        widget.CPU(
            foreground=variables.COLORS["red"], padding=5, format="{load_percent}%"
        ),
        widget.Sep(
            linewidth=1,
            padding=20,
        ),
        widget.TextBox(
            foreground=variables.COLORS["background"],
            background=variables.COLORS["green"],
            fontsize=20,
            padding=5,
            text="",
        ),
        widget.Memory(
            foreground=variables.COLORS["green"],
            measure_mem="G",
            padding=5,
        ),
        widget.Sep(
            linewidth=1,
            padding=20,
        ),
        widget.TextBox(
            foreground=variables.COLORS["background"],
            background=variables.COLORS["yellow"],
            fontsize=20,
            padding=5,
            text="",
        ),
        widget.Volume(
            foreground=variables.COLORS["yellow"],
            fmt=" {}",
            padding=5,
        ),
        widget.Sep(
            linewidth=1,
            padding=5,
        ),
        widget.Clock(
            foreground=variables.COLORS["cyan"],
            padding=5,
            format="%a %d %b  %I:%M %P",
        ),
        widget.Sep(
            linewidth=1,
            padding=5,
        ),
        widget.Systray(),
        widget.Sep(
            linewidth=1,
            padding=10,
        ),
    ]
    return widgets


def init_widgets_secondary_screens():
    """Returns a list of widgets for secondary screens"""
    widgets = init_widgets()
    return widgets[0:8]


def init_screens():
    """Returns a list of screens"""
    screens = [
        Screen(
            top=bar.Bar(
                init_widgets(),
                23,
                border_color=variables.COLORS["background"],
                border_width=4,
            ),
            wallpaper=select_random_wallpaper(),
            wallpaper_mode="fill",
        ),
        Screen(
            top=bar.Bar(
                init_widgets_secondary_screens(),
                24,
            ),
            wallpaper=select_random_wallpaper(),
            wallpaper_mode="fill",
        ),
    ]
    return screens
