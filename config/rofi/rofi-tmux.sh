#! /usr/bin/env bash

session=$( (echo 'Create new session'; tmux list-sessions -F '#S') | rofi -dmenu -p "Select tmux session")

if [[ "Create new session" = "${session}" ]]; then
    kitty -e tmux new -s "$(rofi -dmenu -p ">>> Session name: ")" &
elif [[ -z "${session}" ]]; then
    echo "Cancel"
else
    kitty -e tmux attach -t "${session}" &
fi
