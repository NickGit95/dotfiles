#!/usr/bin/env bash
set -euo pipefail

COMMAND="${1:-save}"
mkdir -p "$HOME/Pictures/screenshots/"

# The first option is a command for scrot to take
case "$COMMAND" in
save)
    shift
    slurp | grim -g - "$HOME/Pictures/screenshots/$(date +%s).png"
    ;;
clipboard)
    shift
    slurp | grim -g - - | wl-copy
    ;;
*) ;;

esac
