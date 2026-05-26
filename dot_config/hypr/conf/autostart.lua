-- Execute your favorite apps at launch
hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd("waybar")
    hl.exec_cmd("udiskie -a -s -m flat")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
end)
