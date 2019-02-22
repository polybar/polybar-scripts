#!/bin/sh

BAR_HEIGHT=22
YAD_WIDTH=200
YAD_HEIGHT=200
DATE="$(date +"%a %d %H:%M")"

case "$1" in
--popup)
    eval "$(xdotool getmouselocation --shell)"
    eval "$(xdotool getdisplaygeometry --shell)"

    # X
    if [ "$((X + 35 + YAD_WIDTH / 2))" -gt "$WIDTH" ]; then #Right side
        : $((pos_x = WIDTH - 35 - YAD_WIDTH))
    elif [ "$((X - YAD_WIDTH / 2))" -lt 1 ]; then #Left side
        : $((pos_x = 10))
    else #Center
        : $((pos_x = X - YAD_WIDTH / 2))
    fi

    # Y
    if [ "$((Y + YAD_HEIGHT))" -gt "$HEIGHT" ]; then #Bottom
        : $((pos_y = HEIGHT - BAR_HEIGHT - YAD_HEIGHT))
    else #Top
        : $((pos_y = Y + BAR_HEIGHT))
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
        --title="yad-calendar" >/dev/null
    ;;
*)
    echo "$DATE"
    ;;
esac
