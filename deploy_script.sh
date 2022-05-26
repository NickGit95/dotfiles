#!/usr/bin/env bash
set -euo pipefail

# Install basic programs
sudo pacman -Sy --noconfirm kitty vim neovim emacs chezmoi qutebrowser ripgrep fd shfmt wget bash-language-server shellcheck aspell aspell-en aspell-es

# Install fonts
sudo pacman -Sy --noconfirm ttf-ubuntu-font-family adobe-source-sans-fonts adobe-source-han-sans-jp-fonts ttf-font-awesome

# Install optional programs
read -r -p "Install optional programs? [y/N] "
if [[ $REPLY == [yY] ]]; then
    (
        cd /tmp
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
    )
    printf "\n Paru (AUR helper) installed!"
    sudo pacman -Sy --noconfirm lutris steam tldr wget zip unzip pass pass-otp neofetch bleachbit virt-manager
    paru -S brave-bin freetube discord_arch_electron librewolf-bin proton-ge-custom-bin
fi

# Install go and some utilities
read -r -p "Install go and utilities? "
if [[ $REPLY == [yY] ]]; then
    wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz -O /tmp/go.tar.gz
    [[ -e "/tmp/go.tar.gz" ]] && rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
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
read -r -p "Install python utilities? "
if [[ $REPLY == [yY] ]]; then
    sudo pacman -Sy --noconfirm python-black pyright python-pip
    sudo python -m pip install pylint
    sudo python -m pip install pytest
    sudo python -m pip install pipenv
    printf "\nPython utilities installed!"
fi

# Install some dotfiles
chezmoi init https://github.com/NickGit95/dotfiles.git
chezmoi apply

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
