#!/usr/bin/env bash
set -euo pipefail

COMMAND="${1:-save}"
mkdir -p "$HOME/Pictures/screenshots/"

# The first option is a command for scrot to take
case "$COMMAND" in
    save)
        shift
        scrot "$@" "$HOME/Pictures/screenshots/$(date +%s).png"
        ;;
    clipboard)
        shift
        scrot "$@" -e 'xclip -selection clipboard -t image/png -i $f'
        ;;
    *) ;;

esac
