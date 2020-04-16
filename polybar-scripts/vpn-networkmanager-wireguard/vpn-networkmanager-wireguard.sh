#!/bin/sh

WIREGUARD_NETWORK_INTERFACE=$1

check_connection_status() {
    nmcli -f GENERAL.STATE con show "${WIREGUARD_NETWORK_INTERFACE}" | grep activated > /dev/null
    echo $?
}

case "$2" in
--toggle)
    if [  "$(check_connection_status)" -eq 0 ]; then
        nmcli connection down "${WIREGUARD_NETWORK_INTERFACE}"  > /dev/null
    else
        nmcli connection up "${WIREGUARD_NETWORK_INTERFACE}"  > /dev/null
    fi
    ;;
*)
    if [ "$(check_connection_status)" -eq 0 ]; then
        echo "#1 wireguard : ${WIREGUARD_NETWORK_INTERFACE}"
    else
        echo "#2 wireguard : off"
    fi
    ;;
esac
