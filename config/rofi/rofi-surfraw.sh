#!/usr/bin/env bash

# Use surfraw in tandem with rofi to create a menu for searching the web

engine_list=$(surfraw -elvi | awk -F'-' '{ print $1 }' | sed '/ELVI/d')

elvi=$(echo "$engine_list" | rofi -dmenu -p "Search >")

if [ -z "$elvi" ]; then
    exit 0
else
    engine=$(echo "$elvi" | awk '{ print $1 }')
    query=$(rofi -dmenu  -p "$engine >")
fi

surfraw "$engine" "$query"
