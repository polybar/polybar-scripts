#!/bin/sh

connection_status() {
    if [ -f "$config" ]; then
        connection=$(sudo wg show "$name" 2>/dev/null | head -n 1 | awk '{print $NF }')

        if [ "$connection" = "$name" ]; then
            echo "1"
        else
            echo "2"
        fi
    else
        echo "3"
    fi
}

name="$1"
# where do you keep your wg config files? make sure you have read access (without sudo)
# if your configs are installed to /etc/wireguard, you need to chmod 755 /etc/wireguard,
# use $name instead of $config in the toggle block, and edit the following path
config="$HOME/wg/$name.conf"

case "$2" in
--toggle)
    if [ "$(connection_status)" = "1" ]; then
        sudo wg-quick down "$config" 2>/dev/null
    else
        sudo wg-quick up "$config" 2>/dev/null
    fi
    ;;
*)
    if [ "$(connection_status)" = "1" ]; then
        echo "#1 $name"
        # alternatively use below commands to print VPN's IP/subnet
        # vpn_ip=$(ip a show $name primary | grep "inet" | awk -v OFS="\n" '{ print $2 }')
        # echo $vpn_ip
    elif [ "$(connection_status)" = "3" ]; then
        echo "#3 Config not found!"
    else
        echo "#2 down"
        # alternatively use a symbol:
        # color="#f90000"
        # echo "%{T2}%{F$color}%{F-T-}"
    fi
    ;;
esac
