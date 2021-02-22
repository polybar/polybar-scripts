#!/bin/sh


icon_pos=$1
max_width=$2
scroll=$3
step=$4
start="0"


player_status=$(playerctl status 2> /dev/null)

show(){
    artist=$(playerctl metadata artist)
    if [ -n "$artist" ];then
        artist=' - '$artist
    fi
    show=$(playerctl metadata title)$artist
}

print(){
    if [ ${#show} -gt "$max_width" ]; then
        omit=""
        "$scroll" != "false" || omit="..."
        if [ "$icon_pos" = "left" ]; then
            echo "$1${show: $start: $max_width}$omit"
        else
            echo "${show: $start: $max_width}$omit$1"
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
            echo 0 &> ~/temp/currentsongindex
            echo "$song_title" &> ~/temp/currentsong
        else
            #update index
            currentsongindex=$(cat ~/temp/currentsongindex 2> /dev/null);

            start=$(("$currentsongindex" + "$step"))
            while [ "${show: $start:1}" = " " ];
            do
                start=$(("$start" + "$step"))
            done
            # reset index
            if [ $(( "$start" - "$step" + "$max_width" )) -gt  ${#show} ]; then
                start="0"
            fi
            echo "${start}" &> ~/temp/currentsongindex
        fi
    else
        start="0"
    fi
    print " ⏸ "

elif [ "$player_status" = "Paused" ]; then
    show 
    echo 0 &> ~/temp/currentsongindex
    print " ⏵ "
else    
    echo ""
fi
