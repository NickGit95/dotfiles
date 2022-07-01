#!/usr/bin/env bash
shopt -s nullglob globstar
set -euo pipefail

mode=${1:-pass}

# Search all the gpg files on the password store
prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=("$prefix"/**/*.gpg)
password_files=("${password_files[@]#"$prefix"/}")
password_files=("${password_files[@]%.gpg}")

# Create the rofi command and filter some unneded options
password_list=$(printf '%s\n' "${password_files[@]}" | grep -v "Codes")
rofi_command="rofi -theme-str 'window {width: 18%;}' -dmenu -i -no-custom"

# Call the pass command based on the mode
if [[ $mode == "OTP" ]]; then
    password_list=$(grep "OTP" <<<"$password_list")
    my_pass=$(eval "$rofi_command" <<<"$password_list")
    [[ -n $my_pass ]] || exit
    pass otp -c "$my_pass" 2>/dev/null
else
    password_list=$(grep -v "OTP" <<<"$password_list")
    my_pass=$(eval "$rofi_command" <<<"$password_list")
    [[ -n $my_pass ]] || exit
    pass -c "$my_pass" 2>/dev/null
fi
