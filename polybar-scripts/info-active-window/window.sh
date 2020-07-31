#!/bin/bash

wm_class=`xprop -id $(xdotool getactivewindow) WM_CLASS | awk '{print $4}' | sed 's/"//g' | sed 's/-/ /g'`

if [[ $? != 0 ]]; then
    :
else
    echo "$wm_class"
fi
