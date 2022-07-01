"""General variables"""
import os


# Font
FONT = "Ubuntu"
FONT_SIZE = 14
FONT_PADDING = 3

# Keys
MOD = "mod4"
SHIFT = "shift"
ALT = "mod1"
CONTROL = "control"

# Applications
HOME = os.path.expanduser("~")
EMACS = ["emacsclient", "-c", "-a", "emacs"]
FILE_MANAGER = ["pcmanfm"]
EMAIL = ["thunderbird"]
LOCKER = ["slock"]
RUNNER = ["rofi", "-show", "drun"]
LOCKER_SUPER = ["slock", "systemctl", "suspend", "-i"]
TERMINAL = "kitty"
VOLUME_DOWN = ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"]
VOLUME_MUTE = ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"]
VOLUME_UP = ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"]

# File paths
WALLPAPER_DIR = HOME + "/Wallpapers/"
CONFIG_DIR = HOME + "/.config/qtile/"
AUTO_START = CONFIG_DIR + "scripts/autostart.sh"
PASS_SCRIPT = CONFIG_DIR + "scripts/passfi.sh"
OTP_SCRIPT = PASS_SCRIPT + " OTP"
LOGIN_SCRIPT = CONFIG_DIR + "scripts/login.sh"
SCREENSHOT = CONFIG_DIR + "scripts/screenshots.sh save -s"
SCREENSHOT_CLIP = CONFIG_DIR + "scripts/screenshots.sh clipboard -s"

# Colors
COLORS = {
    "background": "#282a36",
    "background-alt": "#44475a",
    "background-attention": "#181920",
    "border": "#282a36",
    "current-line": "#44475a",
    "selection": "#44475a",
    "foreground": "#f8f8f2",
    "foreground-alt": "#666666",
    "foreground-attention": "#ffffff",
    "comment": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "orange": "#ffb86c",
    "pink": "#ff79c6",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
}
