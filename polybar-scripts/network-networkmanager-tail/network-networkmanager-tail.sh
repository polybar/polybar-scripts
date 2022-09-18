#!/bin/sh

TEXT_CONNECTED="✓"
TEXT_DISCONNECTED="❌"
# shellcheck disable=SC2016
MSG_CMD='[ "$C_STATE" = "activated" ] && echo "$TEXT_CONNECTED" || echo "$TEXT_DISCONNECTED"'

usage() {
    echo "$0: monitor NetworkManager connection status"
    echo
    echo "Usage:"
    echo "    $0 [-hcdf] names ..."
    echo
    echo "Options:"
    echo "-h  Displays this message"
    echo "-c  Text to print when connected. '$TEXT_CONNECTED' by default."
    echo "-d  Text to print when disconnected. \"$TEXT_DISCONNECTED\" by default."
    echo "-f  Custom print command. '$MSG_CMD' by default."
    echo
    echo "Positional arguments:"
    echo "    names - the names/UUIDs of the connections to monitor"
    echo
}

on_con_change() {
    nmcli -g name,type,device,state,uuid connection show | while read -r line; do
        # shellcheck disable=SC2034
        echo "$line" | while IFS=":" read -r C_NAME C_TYPE C_DEVICE C_STATE C_UUID; do
            for con in "$@"; do
                if [ "$C_NAME" = "$con" ] || [ "$C_UUID" = "$con" ]; then
                    eval "$MSG_CMD"
                fi
            done
        done
    done
}

main() {
    while :; do
        case $1 in
            -h)
                usage "$0"
                exit
                ;;
            -c)
                TEXT_CONNECTED="$2"
                shift
                ;;
            -d)
                TEXT_DISCONNECTED="$2"
                shift
                ;;
            -f)
                MSG_CMD="$2"
                shift
                ;;
            *)
                break;
        esac
        shift
    done

    if [ -z "$1" ]; then
        echo "Error: no connection name provided"
        usage "$0"
        exit 1
    fi

    if ! command -v nmcli >/dev/null 2>&1; then
        echo "Error: nmcli not found"
        exit 2
    fi

    # make sure output isn't empty
    on_con_change "$@"

    nmcli monitor | while read -r line; do
        # the case statement is used for glob support
        case "$line" in
                *disconnected)
                    on_con_change "$@"
                    ;;
                *connected)
                    on_con_change "$@"
                    ;;
        esac
    done
}

main "$@"

