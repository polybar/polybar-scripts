#!/bin/bash

numberOfDesktops=$(wmctrl -d | wc -l)
currentDesktop=$(qdbus org.kde.KWin /KWin currentDesktop)
previousDesktop=$((currentDesktop - 1))

if [[ $currentDesktop = 1 ]]; then
    qdbus org.kde.KWin /KWin setCurrentDesktop "$numberOfDesktops"
else
    qdbus org.kde.KWin /KWin setCurrentDesktop $previousDesktop
fi
