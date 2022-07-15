#! /usr/bin/env bash

function tmux_sessions()
{
    tmux list-session -F '#S'
}

TMUX_SESSION=$( (echo new; tmux_sessions) | rofi -dmenu -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
    kitty -e tmux new-session &
elif [[ -z "${TMUX_SESSION}" ]]; then
    echo "Cancel"
else
    kitty -e tmux attach -t "${TMUX_SESSION}" &
fi
