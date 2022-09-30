#!/usr/bin/env bash
set -euo pipefail

# Install basic programs
echo "Remember to enable multilib repositories and set up NetworkManager"
read -n 1 -r -p "Install basic programs? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --noconfirm kitty vim neovim \
    emacs qutebrowser ripgrep fd shfmt wget bash-language-server \
    shellcheck aspell aspell-en aspell-es mpv pass pass-otp \
    papirus-icon-theme imv sddm xdg-utils git

# Install KDE plasma and utilities
read -n 1 -r -p "Install KDE plasma and basic utils? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S plasma sddm dolphin
    sudo systemctl enable sddm
fi

# Install KDE plasma and utilities
read -n 1 -r -p "Install nvidia utils? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S nvidia nvidia-utils nvidia-settings
fi

# Install basic utilities for qtile
read -n 1 -r -p "Install basic utilities for qtile? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S qtile polkit seahorse \
    lxsession-gtk3 gnome-keyring network-manager-applet pipewire \
    pipewire-alsa alsa-utils pipewire-pulse rofi dunst pcmanfm pavucontrol \
    scrot

# Install x11 only utilities
read -n 1 -r -p "Install X11 programs? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --noconfirm xorg slock xss-lock picom xclip

# Install fonts
read -n 1 -r -p "Install fonts? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --noconfirm ttf-ubuntu-font-family \
    adobe-source-sans-fonts adobe-source-han-sans-jp-fonts \
    ttf-nerd-fonts-symbols-2048-em noto-fonts-emoji

# Install optional programs
read -n 1 -r -p "Install optional programs (AUR stuff)? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then

    read -n 1 -r -p "Install AUR helper paru? [y/N]"
    echo
    if [[ $REPLY == [yY] ]]; then
	(
	    cd /tmp
	    git clone https://aur.archlinux.org/paru.git
	    cd paru
	    makepkg -si
	)
	printf "\n Paru (AUR helper) installed!"
    fi
    sudo pacman -S --noconfirm lutris steam tldr wget zip \
        unzip neofetch bleachbit virt-manager syncthing thunderbird
    paru -S brave-bin freetube-bin tutanota-desktop-bin \
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
    echo
fi

# Install doom emacs
read -n 1 -r -p "Configure doom emacs? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d
    "$HOME"/.emacs.d/bin/doom install
fi

sudo pacman -Syu
