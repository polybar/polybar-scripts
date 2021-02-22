#!/bin/sh


icon_pos=$1
max_width=$2
scroll=$3
step=$4

player_status=$(playerctl status 2> /dev/null)

function show(){
    artist=$(playerctl metadata artist)
    if [ -n "$artist" ];then
        artist=' - '$artist
    fi
    show=$(playerctl metadata title)$artist
}

function print(){
    if [ ${#show} -gt $max_width ]; then
        "$scroll" != "false" || omit="..."
        if [ "$icon_pos" = "left" ]; then
            echo $1${show: $start: $max_width}$omit
        else
            echo ${show: $start: $max_width}$omit$1
        fi
    else
        if [ "$icon_pos" = "left" ]; then
            echo $1$show
        else
            echo $show$1
        fi
    fi
}

if [ "$player_status" = "Playing" ]; then
    show
    if [ "$scroll" = "true" ]; then

        currentsong=$(cat ~/temp/currentsong 2> /dev/null)

        if [ "$currentsong" != "$(playerctl metadata title)" ]; then
            start="0"
            echo 0 &> ~/temp/currentsongindex
            echo $(playerctl metadata title) &> ~/temp/currentsong
        else
            #update index
            currentsongindex=$(cat ~/temp/currentsongindex 2> /dev/null);

            start=`expr $currentsongindex + $step`
            while [ "${show: $start:1}" = " " ];
            do
                start=`expr $start + $step`
            done
            # reset index
            if [ `expr $start - $step + $max_width` -gt  ${#show} ]; then
                start="0"
            fi
            echo $start &> ~/temp/currentsongindex
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
