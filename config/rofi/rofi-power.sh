#!/usr/bin/env bash

power_off=' Power Off'
reboot=' Reboot'
lock=' Lock'
suspend='鈴 Suspend'

confirm() {
    prompt="Are you sure?"
    answer=$(echo -e "No\nYes" | rofi -dmenu -i -p "$prompt ")
    if [ "$answer" == "Yes" ]; then
        return 0;
    else
        return 1;
    fi
}

chosen=$(printf '%s;%s;%s;%s\n' "$power_off" "$reboot" "$lock" "$suspend" | rofi -dmenu -i -sep ';')

case "$chosen" in
    "$power_off")
        if confirm; then
            systemctl poweroff
        else
            exit
        fi
        ;;

    "$reboot")
        if confirm; then
            systemctl reboot
        else
            exit
        fi
        ;;

    "$lock")
        "$HOME/.config/sway/lock.sh"
        ;;

    "$suspend")
        playerctl pause
        systemctl suspend
        ;;

    *) exit 1 ;;
esac

