#!/usr/bin/env bash

function run() {
    if ! pgrep "$1" >/dev/null; then
        "$@" &
    fi
}
setxkbmap latam
setxkbmap -option caps:escape
xset r rate 300 35
xset s 240
run xss-lock -- slock
run picom --experimental-backends -b
run nm-applet
run lxsession
#/usr/bin/emacs --daemon &
run dunst
