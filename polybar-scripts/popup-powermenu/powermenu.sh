#!/bin/sh

action=$(yad --width 300 --entry --undecorated --title "System Logout" \
    --image=gnome-shutdown \
    --button="ok:0" --button="cancel:1" \
    --text "Choose action:" \
    --entry-text \
    "Shutdown" "Reboot" "Logout" "Suspend" )

ret=$?
[[ $ret -eq 1 ]] && exit 0


case $action in
    Shutdown*) cmd="poweroff" ;;
    Reboot*) cmd="reboot" ;;
    Logout*) cmd="echo logout";;
    Suspend*) cmd="echo suspend" ;;
    *) exit 1 ;;    
esac

eval exec $cmd
