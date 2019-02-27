#!/bin/sh

CONFIG_PATH=~/wg/wireguard.conf

SHOW_NAME=false #Show connection name instead of CONNECTED_TEXT

CONNECTED_ICON="#1 VPN:"
CONNECTED_TEXT="up"

DISCONNECTED_ICON="#2 VPN:"
DISCONNECTED_TEXT="down"

check() {
    if [ -f $CONFIG_PATH ]; then
        EXIST=true
    else
        EXIST=false
    fi

    CONFIG_NAME=$(basename "${CONFIG_PATH%.*}")
    WG_RESULT=$(sudo wg show "$CONFIG_NAME" 2>/dev/null | head -n 1 | awk '{print $NF }')

    if [ "$WG_RESULT" = "$CONFIG_NAME" ]; then
        CONNECTED=true
    else
        CONNECTED=false
    fi
}

status() {
    check
    if $EXIST; then
        if $CONNECTED; then
            if $SHOW_NAME; then
                CONNECTED_TEXT=$CONFIG_NAME
            fi
                echo "$CONNECTED_ICON $CONNECTED_TEXT"
        else
            echo "$DISCONNECTED_ICON $DISCONNECTED_TEXT"
        fi
    else
        echo "$DISCONNECTED_ICON File not found"
    fi
}

toggle() {
    check
    if $EXIST; then
        FULL_CONFIG_PATH="$(readlink -f "$CONFIG_PATH")"
        if $CONNECTED; then
            sudo wg-quick down "$FULL_CONFIG_PATH" 2>/dev/null
            status
        else
            sudo wg-quick up "$FULL_CONFIG_PATH" 2>/dev/null
            status
        fi
    else
        echo "$DISCONNECTED_ICON File not found"
    fi
}

case "$1" in
--toggle)
    toggle
    ;;
*)
    status
    ;;
esac
