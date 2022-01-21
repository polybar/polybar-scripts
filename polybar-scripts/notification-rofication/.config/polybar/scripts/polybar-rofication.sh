#!/bin/bash

rofication_print() {
    status=$(rofication-status)
    if [ $status = '?' ]; then
        printf $status
    elif [ $status -gt 0 ]; then
        printf " %s" "$status"
    else
        printf ""
    fi
    printf '\n'
}

rofication_show() {
    rofication-gui
}

case "$1" in
    --show)
        rofication_show
        ;;
    *)
        rofication_print
        ;;
esac
