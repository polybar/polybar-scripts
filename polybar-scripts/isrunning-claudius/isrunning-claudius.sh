#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep claudius)" ]; then
            pkill claudius
        else
            claudius &
        fi
        ;;
    *)
        if [ "$(pgrep claudius)" ]; then
            echo "#1"
        else
            echo "#2"
        fi
        ;;
esac
