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
        if [ "$(wmname)" != "BSPWM" ]; then
        # echo LG3D
        	echo "$(wmname)"
        else
        # echo bswpwm
        	echo "$(wmname) "
        fi
        ;;
esac
