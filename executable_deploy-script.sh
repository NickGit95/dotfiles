#!/usr/bin/env bash
set -euo pipefail

# Install basic utilities (qtile)
read -n 1 -r -p "Install basic programs for qtile? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --noconfirm polkit seahorse \
    lxsession-gtk3 gnome-keyring network-manager-applet pipewire \
    pipewire-alsa alsa-utils pipewire-pulse rofi dunst thunar pavucontrol-qt

# Install x11 only utilities
sudo pacman -S --noconfirm xorg slock xss-lock picom

# Install basic programs
sudo pacman -S --noconfirm kitty vim neovim emacs chezmoi \
    qutebrowser qtile ripgrep fd shfmt wget bash-language-server \
    shellcheck aspell aspell-en aspell-es mpv pass \
    pass-otp papirus-icon-theme imv

# Install fonts
sudo pacman -S --noconfirm ttf-ubuntu-font-family \
    adobe-source-sans-fonts adobe-source-han-sans-jp-fonts \
    ttf-nerd-fonts-symbols

# Install optional programs
read -n 1 -r -p "Install optional programs? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then
    (
        cd /tmp
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
    )
    printf "\n Paru (AUR helper) installed!"
    sudo pacman -S --noconfirm lutris steam tldr wget zip \
        unzip neofetch bleachbit virt-manager
    paru -S brave-bin freetube discord-canary-electron-bin \
        librewolf-bin proton-ge-custom-bin
fi

# Install go and some utilities
read -n 1 -r -p "Install go and utilities? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then
    wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz -O /tmp/go.tar.gz
    [[ -e "/tmp/go.tar.gz" ]] && rm -rf /usr/local/go &&
        sudo tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
    /usr/local/go/bin/go version
    printf "\nGolang installed!"

    /usr/local/go/bin/go install github.com/x-motemen/gore/cmd/gore@latest
    /usr/local/go/bin/go install github.com/stamblerre/gocode@latest
    /usr/local/go/bin/go install golang.org/x/tools/cmd/godoc@latest
    /usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
    /usr/local/go/bin/go install golang.org/x/tools/cmd/gorename@latest
    /usr/local/go/bin/go install golang.org/x/tools/cmd/guru@latest
    /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
    printf "\nGolang utilities installed!"
fi

# Install some python utilities
read -n 1 -r -p "Install python utilities? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --noconfirm python-black pyright python-pip
    sudo python -m pip install pylint
    sudo python -m pip install pytest
    sudo python -m pip install pipenv
    printf "\nPython utilities installed!"
fi

# Install some dotfiles
read -n 1 -r -p "Configure dotfiles? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    chezmoi init https://github.com/NickGit95/dotfiles.git
    chezmoi apply
fi

# Install doom emacs
read -n 1 -r -p "Configure doom emacs? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d
    "$HOME"/.emacs.d/bin/doom install
fi

sudo pacman -Syu
