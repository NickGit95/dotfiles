#!/usr/bin/env bash
set -euo pipefail

# Runner command
runner="fuzzel -d -w 10 -l 4"

# Options list
declare -a options=(
    "⚫ Logout"
    "⏻ Shutdown"
    "⏼ Suspend"
    "⭘ Reboot"
)

# Create the rofi command with the options list
choice=$(printf "%s\n" "${options[@]}" | eval "$runner")
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
    systemctl suspend
    ;;
"Reboot")
    reboot
    ;;
*)
    exit 0
    ;;
esac
