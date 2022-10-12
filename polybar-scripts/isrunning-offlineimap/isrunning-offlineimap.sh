#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep offlineimap)" ]; then
            pkill -f offlineimap
        else
            nohup offlineimap > /tmp/offlineimap.log &
        fi
        ;;
    *)
        if [ "$(pgrep offlineimap)" ]; then
            echo "#1 Online"
        else
            echo "#2 Offline"
        fi
        ;;
esac
