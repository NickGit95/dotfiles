#!/usr/bin/env bash
set -euo pipefail

# Options list
declare -a options=(
    " Logout"
    "⏻ Shutdown"
    "⏼ Suspend"
    "⭘ Reboot"
)

# Create the rofi command with the options list
rofi_command="rofi -theme-str 'window {width: 10%;}' -dmenu -no-custom -i"
choice=$(printf "%s\n" "${options[@]}" | eval "$rofi_command")
[[ -n $choice ]] || exit

# Case statement
choice=$(cut -d' ' -f2 <<<"$choice")
case $choice in
    "Logout")
        kill -9 -1
        ;;
    "Shutdown")
        poweroff
        ;;
    "Suspend")
        slock systemctl suspend -i
        ;;
    "Reboot")
        reboot
        ;;
    *)
        exit 0
        ;;
esac
