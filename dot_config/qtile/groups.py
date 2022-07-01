"""Groups"""
from libqtile.config import Group, Match


def init_groups():
    """Returns a list of groups with their own configurations"""
    return [
        Group(
            "browse",
            matches=[Match(wm_class="brave-browser")],
            init=True,
            persist=True,
            label="爵",
        ),
        Group(
            "kek",
            matches=[Match(wm_class="FreeTube")],
            init=True,
            persist=True,
            label="",
        ),
        Group(
            "code",
            matches=[Match(wm_class="kitty"), Match(wm_class="emacs")],
            init=True,
            persist=True,
            label="",
        ),
        Group("chat", init=True, persist=True, label="ﭮ"),
        Group("draw", init=True, persist=True, label="", layout="floating"),
        Group("game", init=True, persist=True, label="", layout="floating"),
    ]
