aur_helper := "paru"
pacman_args := "--needed"
helper_folder := "/tmp/helper"
alias hook := packages-hook
alias helper := install-helper

default:
  just --list

quick-apply:
  chezmoi apply --exclude scripts

apply:
  chezmoi apply

# Installs the AUR helper
install-helper:
  @rm -rf {{helper_folder}}
  @mkdir -p {{helper_folder}}
  git clone https://aur.archlinux.org/paru.git {{helper_folder}}
  makepkg -si -D {{helper_folder}}
  {{aur_helper}} {{pacman_args}} -Syu

# Installs required packages
sync-packages:
  git pull --autostash
  @{{aur_helper}} {{pacman_args}} -Syu
  @{{aur_helper}} {{pacman_args}} -Sy $(cat _files/packages | tr '\n' ' ')

# Installs required flatpaks
sync-flatpaks:
  flatpak install $(cat _files/flatpaks | tr '\n' ' ')

# Install a git hook which will save all packages names to a file
packages-hook:
  mkdir -p .git/hooks
  cp ./_files/pre-commit-hook.sh .git/hooks/pre-commit
  @chmod +x .git/hooks/pre-commit

