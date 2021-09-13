#!/usr/bin/env bash
set -euo pipefail

yesno() {
    read -r -p "$1 [y/N] "
    if [[ $REPLY == [yY] ]]; then
        echo "yes"
    else
        echo "no"
    fi
}

# Install basic programs
sudo pacman -Sy --noconfirm kitty vim neovim emacs chezmoi qutebrowser ripgrep fd shfmt wget bash-language-server shellcheck

# Install go and some utilities
install_go=$(yesno "Install go and utilities?")
if [[ $install_go == "yes" ]]; then
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
    printf "\nGolang utilities installed!"
fi

# Install some python utilities
install_python=$(yesno "Install python utilities?")
echo "$install_python"
if [[ $install_python == "yes" ]]; then
    sudo pacman -Sy --noconfirm python-black pyright python-pip
    python -m pip install pylint
    printf "\nPython utilities installed!"
fi

# Install some dotfiles
chezmoi init https://github.com/NickGit95/dotfiles.git
chezmoi apply

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
