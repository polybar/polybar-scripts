#!/bin/bash

numberOfDesktops=$(wmctrl -d | wc -l)
currentDesktop=$(qdbus org.kde.KWin /KWin currentDesktop)
nextDesktop=$((currentDesktop + 1))

if [[ $currentDesktop = "$numberOfDesktops" ]]; then
    qdbus org.kde.KWin /KWin setCurrentDesktop 1
else
    qdbus org.kde.KWin /KWin setCurrentDesktop $nextDesktop
fi
