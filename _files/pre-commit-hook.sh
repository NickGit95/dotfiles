#!/usr/bin/env bash

PACKAGES_FILE="_files/packages"

# Get all the currently installed packages into a list
paru -Qqe | sort >"$PACKAGES_FILE"
git add "$PACKAGES_FILE"
