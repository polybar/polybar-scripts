#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x dropbox)" ]; then
            pkill dropbox
        else
            dropbox &
        fi
        ;;
    *)
        if [ "$(pgrep -x dropbox)" ]; then
            echo "#1"
        else
            echo "#2"
        fi
        ;;
esac
