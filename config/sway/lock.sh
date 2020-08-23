#!/bin/bash

set -e

config="$HOME/.config/sway"
wallpapers="$HOME/Pictures/Wallpapers"
list="$config/lockscreen-wallpapers.txt"


swaylock -ef -i "$wallpapers/lock.jpg"
