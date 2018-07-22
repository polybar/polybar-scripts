#!/bin/bash

# dimensions
width=200
height=200
# if used bottom panel (0 if top panel)
bottom=1
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
      yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --width=${width} --height=${height} --posx=${posx} --posy=${posy} > /dev/null
fi
