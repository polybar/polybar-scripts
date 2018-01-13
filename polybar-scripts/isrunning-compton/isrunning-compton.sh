#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x compton)" ]; then
            pkill compton
        else
            compton -b --config ~/.config/compton/config
        fi
        ;;
    *)
        if [ "$(pgrep -x compton)" ]; then
            echo "#1"
        else
            echo "#2"
        fi
        ;;
esac
