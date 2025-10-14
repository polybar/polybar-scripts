#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

#this function slice the artist length to 15 characters and 20 characters for the title preventing it from taking all the polybar space
print_metadata () {
    player_title=$(playerctl metadata title 2> /dev/null)
    player_artist=$(playerctl metadata artist 2> /dev/null)
    if [ "$player_status" = "Playing" ]; then
        echo "#1 ${player_artist::15} - ${player_title::20}"
    elif [ "$player_status" = "Paused" ]; then
        echo "#2 ${player_artist::15} - ${player_title::20}"
    fi
}

if [ "$player_status" = "" ]; then
    echo "#3 No player found"
else
    print_metadata
fi
