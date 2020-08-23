#!/bin/bash

# You can call this script like this:
# ./volumeControl.sh up
# ./volumeControl.sh down
# ./volumeControl.sh mute

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    iconMuted="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
    iconLow="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
    iconMed="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-medium.svg"
    iconHigh="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
    volume=$(get_volume)
    bar=$(seq --separator="─" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    if is_mute || [ "$volume" == "0" ]; then
        dunstify -i $iconMuted -r 2593 -u normal "mute"
    else
        if [ "$volume" -lt "30" ]; then
            dunstify -i $iconLow -r 2593 -u normal " $bar "
        else
            if [ "$volume" -lt "70" ]; then
                dunstify -i $iconMed -r 2593 -u normal " $bar "
            else
                dunstify -i $iconHigh -r 2593 -u normal " $bar "
            fi
        fi
    fi
}

case $1 in
    up)
        # Make sure to set the volume to on in case it was muted
        amixer -D pulse set Master on >/dev/null
        # Raise volume
        amixer -D pulse sset Master 5%+ >/dev/null
        send_notification
    ;;
    down)
        amixer -D pulse set Master on >/dev/null
        amixer -D pulse sset Master 5%- >/dev/null
        send_notification
    ;;
    mute)
        amixer -D pulse set Master 1+ toggle >/dev/null
        send_notification
    ;;
esac
