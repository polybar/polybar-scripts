#!/bin/sh

action=$(yad --width 300 --entry --undecorated --title "System Logout" \
    --image=gnome-shutdown \
    --button="ok:0" --button="cancel:1" \
    --text "Choose action:" \
    --entry-text \
    "Shutdown" "Reboot" "Logout" "Suspend" )

ret=$?
[ $ret -eq 1 ] && exit 0


case $action in
    Shutdown*) cmd="poweroff" ;;
    Reboot*) cmd="reboot" ;;
    Logout*) cmd="bspc quit";;
    Suspend*) cmd="echo suspend" ;;#change the command for suspend and logging out wrt to your convenience
    *) exit 1 ;;    
esac

eval exec "$cmd"
