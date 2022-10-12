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
        echo "# $(wmname)"
        ;;
esac
