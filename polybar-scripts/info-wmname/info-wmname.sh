#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(wmname)" != "BSPWM" ]; then
            wmname BSPWM
        else
            wmname LG3D
        fi
        ;;
    *)
        wmname=$(wmname)
        echo "# $wmname"
        ;;
esac
