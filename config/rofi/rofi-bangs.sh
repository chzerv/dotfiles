#!/usr/bin/env bash
# author: unknown
# sentby: MoreChannelNoise (https://www.youtube.com/user/MoreChannelNoise)
# editby: gotbletu (https://www.youtube.com/user/gotbletu)

# demo: https://www.youtube.com/watch?v=kxJClZIXSnM
# info: this is a script to launch other rofi scripts,
#       saves us the trouble of binding multiple hotkeys for each script,
#       when we can just use one hotkey for everything.

declare -A LABELS
declare -A COMMANDS

###
# List of defined 'bangs'

# launch programs
COMMANDS["Apps"]="rofi -combi-modi window,drun -show combi"
LABELS["Apps"]=""

# tmux
COMMANDS["tmux"]="$HOME/.config/rofi/rofi-tmux.sh"
LABELS["tmux"]=""

# sway window switcher
COMMANDS["Windows"]="$HOME/.config/rofi/rofi-window-switcher.sh"
LABELS["Windows"]=""

# emoji selector
COMMANDS["Emojis"]="$HOME/.config/rofi/rofi-emoji.sh"
LABELS["Emojis"]=""

# Clipboard
COMMANDS["Clipboard"]="clipman pick --tool=rofi -T'--prompt=Clipboard -i'"
LABELS["Clipboard"]=""

# power manager
COMMANDS["Power"]="$HOME/.config/rofi/rofi-power.sh"
LABELS["Power"]=""

# SSH
COMMANDS["SSH"]="rofi -show ssh"
LABELS["SSH"]=""

################################################################################
# do not edit below
################################################################################
##
# Generate menu
##
function print_menu()
{
    for key in ${!LABELS[@]}
    do
  echo "$key    ${LABELS}"
     #   echo "$key    ${LABELS[$key]}"
     # my top version just shows the first field in labels row, not two words side by side
    done
}
##
# Show rofi.
##
function start()
{
    # print_menu | rofi -dmenu -p "?=>" 
    print_menu | sort | rofi -dmenu -mesg ">>> launch your collection of rofi scripts" -i -p "rofi-bangs: "

}


# Run it
value="$(start)"

# Split input.
# grab upto first space.
choice=${value%%\ *}
# graph remainder, minus space.
input=${value:$((${#choice}+1))}

##
# Cancelled? bail out
##
if test -z ${choice}
then
    exit
fi

# check if choice exists
if test ${COMMANDS[$choice]+isset}
then
    # Execute the choice
    eval echo "Executing: ${COMMANDS[$choice]}"
    eval ${COMMANDS[$choice]}
else
 eval  $choice | rofi
 # prefer my above so I can use this same script to also launch apps like geany or leafpad etc (DK) 
 #   echo "Unknown command: ${choice}" | rofi -dmenu -p "error"
fi
