#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -a python | grep claudius)" ]; then
            pkill claudius
        else
            claudius &
        fi
        ;;
    *)
        if [ "$(pgrep -a python | grep claudius)" ]; then
            echo "#1"
        else
            echo "#2"
        fi
        ;;
esac
