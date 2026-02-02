#!/usr/bin/env bash

# Initial setup
read -n 1 -r -p "Run initial setup? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -Sy --needed --noconfirm just
    cd "$HOME/.local/share/chezmoi" || exit
    just install-helper
    just sync-packages
fi

# Initial setup flatpaks
read -n 1 -r -p "Install flatpaks? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -Sy --needed --noconfirm just flatpak
    just sync-flatpaks
fi
