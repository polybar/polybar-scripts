#!/bin/sh

BAR_HEIGHT=22  # polybar height
BORDER_SIZE=1  # border size from your wm settings
YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=188 # 188 is minimum possible value
DATE="$(date +"%a %d %H:%M")"

case "$1" in
--popup)

    :'
    As you seen above min yad size is 222x188 but this is not the full truth,
    in fact min size be 226x192, because the yad increase given values by 4, so in the
    formulas below you can see 2 (when yad width was divided on 2) or 4 (when width has not been divided).
    '

    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
        exit 0
    fi

    eval "$(xdotool getmouselocation --shell)"
    eval "$(xdotool getdisplaygeometry --shell)"

    # X
    if [ "$((X + YAD_WIDTH / 2 + 2 + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
        : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE - 4))
    elif [ "$((X - YAD_WIDTH / 2 - 2 - BORDER_SIZE))" -lt 1 ]; then #Left side
        : $((pos_x = BORDER_SIZE))
    else #Center
        : $((pos_x = X - YAD_WIDTH / 2 - 2))
    fi

    # Y
    if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
        : $((pos_y = HEIGHT - YAD_HEIGHT - 4 - BAR_HEIGHT - BORDER_SIZE))
    else #Top
        : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
        --title="yad-calendar" >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
