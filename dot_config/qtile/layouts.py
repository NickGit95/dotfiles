"""Layout management"""
from libqtile import layout
import variables


def init_layouts():
    """Returns a list of layouts"""
    layouts = [
        layout.MonadTall(
            border_focus=[variables.COLORS["purple"]], margin=8, border_width=1
        ),
        layout.Max(),
        layout.Floating(
            border_focus=[variables.COLORS["purple"]], margin=8, border_width=1
        ),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]
    return layouts
