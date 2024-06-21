#!/usr/bin/env bash
set -euo pipefail

# Install basic programs
echo "Remember to enable multilib repositories and set up NetworkManager"
read -n 1 -r -p "Install basic programs? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --needed --noconfirm kitty vim neovim \
    emacs qutebrowser ripgrep fd shfmt wget bash-language-server yamllint ansible \
    ansible-lint yaml-language-server stylua \
    shellcheck aspell aspell-en aspell-es mpv pass pass-otp \
    papirus-icon-theme imv sddm xdg-utils git cmake gnome-keyring

# Install wayland utilities
read -n 1 -r -p "Install wayland utilities? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed qt5-wayland qt6-wayland xdg-desktop-portal wl-clipboard
fi

# Install hyprland utilities
read -n 1 -r -p "Install hyprland utilities? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed hyprland pamixer dunst wireplumber waybar fuzzel hypridle hyprlock \
        xdg-desktop-portal-hyprland hyprpaper grim slurp qt6ct udiskie
fi

# Install amd utilities
read -n 1 -r -p "Install amd-gpu utilities? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon \
        libva-mesa-driver mesa-vdpau
fi

# Install KDE plasma and utilities
read -n 1 -r -p "Install KDE plasma and basic utils? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed plasma sddm dolphin plasma-wayland-session plasma-wayland-protocols \
        xdg-desktop-portal-kde
    sudo systemctl enable sddm
fi

# Install flatpak apps/runtimes
read -n 1 -r -p "Install flatpak apps? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed --noconfirm flatpak
    flatpak install com.discordapp.Discord com.usebottles.bottles \
        com.valvesoftware.Steam dev.vencord.Vesktop \
        org.freedesktop.Platform.VulkanLayer.MangoHud
fi

# Install nvidia and utilities
read -n 1 -r -p "Install nvidia utils? [y/N]"
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S nvidia nvidia-utils nvidia-settings
fi

# Install basic utilities for pipewire sound
read -n 1 -r -p "Install basic utilities for pipewire? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed pipewire pipewire-alsa alsa-utils pipewire-pulse pavucontrol
fi

# Install basic utilities for qtile
read -n 1 -r -p "Install basic utilities for qtile? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then
    sudo pacman -S --needed qtile polkit seahorse \
        lxsession-gtk3 gnome-keyring network-manager-applet \
        alsa-utils rofi dunst pcmanfm-qt pavucontrol \
        scrot python-pip
    python -m pip install psutil
fi

# Install x11 only utilities
read -n 1 -r -p "Install X11 programs? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --needed --noconfirm xorg slock xss-lock picom xclip

# Install fonts
read -n 1 -r -p "Install fonts? [y/N] "
echo
[[ $REPLY == [yY] ]] && sudo pacman -S --noconfirm ttf-ubuntu-font-family \
    adobe-source-sans-fonts adobe-source-han-sans-jp-fonts \
    nerd-fonts noto-fonts-emoji ttf-roboto

# Install optional programs
read -n 1 -r -p "Install programs from the AUR? [y/N] "
echo
if [[ $REPLY == [yY] ]]; then

    read -n 1 -r -p "Install AUR helper paru? [y/N]"
    echo
    if [[ $REPLY == [yY] ]]; then
        (
            cd /tmp
            git clone https://aur.archlinux.org/paru-bin.git
            cd paru-bin
            makepkg -si
        )
        printf "\n Paru (AUR helper) installed!"
    fi
    sudo pacman -S --noconfirm tldr wget zip \
        unzip neofetch bleachbit virt-manager syncthing thunderbird qemu-full \
        dnsmasq mangohud
    paru -S brave-bin freetube-git tutanota-desktop-bin \
        librewolf-bin
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
    sudo pacman -S --needed --noconfirm python-black pyright python-pip python-pylint
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
