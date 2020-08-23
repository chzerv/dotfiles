#!/bin/bash
declare -A LABELS
declare -A COMMANDS

# List of defined bangs
# Such as :
# Locate, websearch, bookmarks and run

_scripts="$HOME/.local/bin"

# Launch programs:
COMMANDS["Run"]="wofi --show drun"
LABELS["Run"]=""


COMMANDS["Apps"]="$_scripts/rofi-favs.sh"
LABELS["Apps"]==""

# COMMANDS["Emojis"]="~/.scripts/wofi-unicode"
# LABELS["Emojis"]=""
# 
# COMMANDS["Clipboard"]='wofi -modi "clipboard:greenclip print" -show clipboard'
# LABELS["Clipboard"]=""
# 
# COMMANDS["VPN"]="~/.scripts/wofi-vpn1"
# LABELS["VPN"]=""



# Menu
# !! DO NOT EDIT !!

function print_menu() {

	for key in ${!LABELS[@]}
	do
		echo "$key 	${LABELS}"
	done

}

# Show wofi

function start_wofi() {

	print_menu | sort | wofi -dmenu -mesg ">>> Launch scripts.." -i -p "Menu: "

}


# Run wofi

value="$(start_wofi)"

# Split input.
# Grab upto first space:
choice=${value%%\ *}
input=${value:$((${choice}+1))}

# Exit if canceled
if test -z ${choice}
then
	exit
fi

# Check if "choice" exists:
if test ${COMMANDS[$choice]+isset}
then
	# Execute the choice
	eval echo "Executing: ${COMMANDS[$choice]}"
	eval ${COMMANDS[$choice]}
else
	eval $choice | wofi
fi







