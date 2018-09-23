#!/bin/sh

case "$1" in
    --toggle)
        if cmus-remote -Q | grep -q 'status playing'; then
            cmus-remote -u
        else
            cmus-remote -p
        fi
        ;;
    *)
        if cmus-remote -Q | grep -q 'status playing'; then
            cmus-remote -Q | grep 'file' | awk -F/ '{print $NF}'
        fi
        ;;
esac
