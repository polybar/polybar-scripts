#!/bin/sh

network_print() {
    CONNECTION_LIST=$(nmcli -t -f name,type,device,state connection show --active 2>/dev/null | grep -v ':bridge:')
    CONNECTION_COUNT=$(echo "$CONNECTION_LIST" | wc -l)

    counter=0

    if [ "$CONNECTION_COUNT" -ne 0 ]; then
        echo "$CONNECTION_LIST" | while read -r line; do
            counter=$((counter + 1))

            description=$(echo "$line" | cut -d ':' -f 1)
            type=$(echo "$line" | cut -d ':' -f 2)
            device=$(echo "$line" | cut -d ':' -f 3)
            state=$(echo "$line" | cut -d ':' -f 4)

            if [ "$state" = "activated" ]; then
                if [ "$type" = "802-11-wireless" ]; then
                    icon="#1"

                    signal=$(nmcli -t -f in-use,signal device wifi list ifname "$device" | grep "\*" | cut -d ':' -f 2)
                    if [ "$signal" -lt 40 ]; then
                        description="$description - %{F#f9cc18}$signal%%{F-}"
                    fi
                elif [ "$type" = "802-3-ethernet" ]; then
                    icon="#2"

                    speed="$(cat /sys/class/net/"$device"/speed)"
                    if [ "$speed" -ne -1 ]; then
                        if [ "$speed" -eq 1000 ]; then
                            speed="1G"
                        else
                            speed=$speed"M"
                        fi
                    else
                        speed="?"
                    fi

                    description="$description - $speed"
                fi

                printf '%s %s' "$icon" "$description"

                if [ "$CONNECTION_COUNT" -ne $counter ]; then
                    printf "     "
                else
                    printf "\n"
                fi
            fi
        done
    else
        echo "#3"
    fi
}

network_update() {
    pid=$(cat "$path_pid")

    if [ "$pid" != "" ]; then
        kill -10 "$pid"
    fi
}

path_pid="/tmp/polybar-network-networkmanager.pid"

case "$1" in
    --update)
        network_update
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            network_print

            sleep 60 &
            wait
        done
        ;;
esac
