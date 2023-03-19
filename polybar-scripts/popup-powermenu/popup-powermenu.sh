#!/bin/sh

case "$1" in
    --popup)
        yad=$(yad --width 300 --entry --undecorated --title "System Logout" --image=gnome-shutdown --text "Choose action:" --entry-text "Shutdown" "Reboot" "Logout" "Suspend")

        case "$yad" in
            Shutdown)
                poweroff
                ;;
            Reboot)
                reboot
                ;;
            Suspend)
                hibernate
                ;;
            Logout)
                bspc quit
                ;;
        esac
        ;;
    *)
        echo "#1"
        ;;
esac
