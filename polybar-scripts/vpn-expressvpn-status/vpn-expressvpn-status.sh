#!/bin/sh

STATUS=$(expressvpn status)

expressvpn_toggle() {
    if [ "$STATUS" != 'Not connected' ]; then
        expressvpn disconnect
    else
        expressvpn connect
    fi
}

expressvpn_status() {
    if [ "$STATUS" != 'Not connected' ]; then
        echo "$STATUS" | head -n1 | cut -d'-' -f2
    else
        echo 'not connected'
    fi
}

case "$1" in
    --toggle)
        expressvpn_toggle
    ;;
    *)
        expressvpn_status
    ;;
esac
