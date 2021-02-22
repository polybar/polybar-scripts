#!/bin/sh


icon_pos=$1
max_width=$2
scroll=$3
step=$4


player_status=$(playerctl status 2> /dev/null)

show(){
    artist=$(playerctl metadata artist)
    if [ -n "$artist" ];then
        artist=' - '$artist
    fi
    show=$(playerctl metadata title)$artist
}

print(){
    show=$2
    if [ ${#show} -gt "$max_width" ]; then
        omit=""
        "$scroll" != "false" || omit="..."

        content=$(echo "$show" | awk -v start="$start" -v max="$max_width"  '{ content=substr($0, start, max); print content; }' )

        if [ "$icon_pos" = "left" ]; then
            echo "$1$content$omit"
        else
            echo "$content$omit$1"
        fi
    else
        if [ "$icon_pos" = "left" ]; then
            echo "$1$show"
        else
            echo "$show$1"
        fi
    fi
}

if [ "$player_status" = "Playing" ]; then
    show
    if [ "$scroll" = "true" ]; then

        currentsong=$(cat ~/temp/currentsong 2> /dev/null)

        song_title="$(playerctl metadata title)"
        if [ "$currentsong" != "$song_title" ]; then
            start="0"
            echo 0 > ~/temp/currentsongindex 2>&1
            echo "$song_title" > ~/temp/currentsong 2>&1
        else
            #update index
            currentsongindex=$(cat ~/temp/currentsongindex 2> /dev/null);

            start=$(("$currentsongindex" + "$step"))
            # reset index
            if [ $(( "$start" - "$step" + "$max_width" )) -gt  ${#show} ]; then
                start="0"
            fi
            echo "${start}" > ~/temp/currentsongindex 2>&1
        fi
    else
        start="0"
    fi
    print " ⏸ " "$show"

elif [ "$player_status" = "Paused" ]; then
    show 
    echo 0 > ~/temp/currentsongindex 2>&1
    print " ⏵ " "$show"
else    
    echo ""
fi
