#!/bin/bash

# dimensions
width=200
height=200
# if used bottom panel (0 if top panel)
bottom=1
# popup method: "yad" or "rofi" (yad is better for this purpose)
popup="yad"
# rofi theme, must be theme where location can be set, for example:
rofitheme="/usr/share/rofi/themes/Arc-Dark.rasi"
# date string
date="$(date +"%a %d %H:%M")"

echo "$date"
if [[ $1 = "click" ]]; then
   eval "$(xdotool getmouselocation --shell)"
   if [[ $bottom -eq 1 ]]; then
      (( posy = Y - height - 20 ))
      (( posx = X - (width / 2) ))
   else
      (( posy = Y + 20 ))
      (( posx = X - (width / 2) ))
   fi
   if [[ $popup = "rofi" ]]; then
      cal --color=always | sed 's/\x1b\[[7;]*m/\<b\>\<u\>/g' | sed 's/\x1b\[[27;]*m/\<\/u\>\<\/b\>/g' | tail -n +2 | rofi -dmenu -location 1 -width ${width} -lines 9 -markup-rows -p "$date" > /dev/null -hide-scrollbar -xoffset ${posx} -yoffset ${posy} -font "monospace 9" -click-to-exit -theme ${rofitheme}
   elif [[ $popup = "yad" ]]; then
      yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --width=${width} --height=${height} --posx=${posx} --posy=${posy} > /dev/null
   fi
fi
