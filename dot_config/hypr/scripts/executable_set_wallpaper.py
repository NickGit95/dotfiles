#!/usr/bin/env python3

import os
import random
import subprocess


# Make sure the wallpaper is an image file
def is_image_file(file_name):
    image_extensions = [".jpg", ".png"]
    return any(file_name.lower().endswith(ext) for ext in image_extensions)


# Get a list of wallpapers
def get_wallpapers(directory):
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            if is_image_file(file_path):
                file_paths.append(file_path)
    return file_paths


# Get a list of wallpapers from the wallpaper folder and chose a random one
active = subprocess.run(
    ["hyprctl", "hyprpaper", "listactive"], capture_output=True, text=True, check=True
).stdout
wallpaper_list = get_wallpapers("/home/nick/Wallpapers/4k")
random_wallpaper = random.choice(wallpaper_list)

# Load and set the new wallpaper
subprocess.run(
    ["hyprctl", "hyprpaper", "preload", random_wallpaper],
    capture_output=True,
    check=True,
)
subprocess.run(
    ["hyprctl", "hyprpaper", "wallpaper", f",{random_wallpaper}"],
    capture_output=True,
    check=True,
)
subprocess.run(
    ["hyprctl", "hyprpaper", "unload", active], capture_output=True, check=True
)
