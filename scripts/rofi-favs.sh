#!/bin/bash

DIALOG_RESULT=$(echo -e 'File Manager\nFirefox\nAlacritty\nSpotify\nDiscord\nEmacs' | wofi --show dmenu -i -p "Apps:")

case "$DIALOG_RESULT" in
		"File Manager") exec nautilus ;;
		"Firefox") exec firefox ;;
                "Alacritty") exec alacritty ;;
		"Spotify") flatpak run com.spotify.Client;;
		"Discord") flatpak run com.discordapp.Discord;;
		"Emacs") exec emacs;;
esac
