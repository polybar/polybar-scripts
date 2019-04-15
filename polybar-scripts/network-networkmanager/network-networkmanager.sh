#!/bin/sh

network_print() {
    CONNECTION_LIST=$(nmcli -t -f name,type,device,state connection show --active 2>/dev/null)
    CONNECTION_COUNT=$(nmcli -t -f name connection show --active | wc -l 2>/dev/null)

    output=""
    counter=0

    if [ "$CONNECTION_COUNT" -ne 0 ]; then
        for connection in $CONNECTION_LIST; do
            counter=$((counter + 1))

            description=$(echo "$connection" | cut -d ':' -f 1)
            type=$(echo "$connection" | cut -d ':' -f 2)
            device=$(echo "$connection" | cut -d ':' -f 3)
            state=$(echo "$connection" | cut -d ':' -f 4)

            if [ "$state" = "activated" ]; then
                if [ "$type" = "802-11-wireless" ]; then
                    icon="#1"

                    signal=$(nmcli -t -f in-use,signal device wifi list ifname "$device" | grep "\*" | cut -d ':' -f 2)
                    if [ "$signal" -lt 40 ]; then
                        description="$description - %{F#f9cc18}$signal%%{F-}"
                    fi
                else
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

                if [ "$CONNECTION_COUNT" -ne $counter ]; then
                    spacer="     "
                else
                    spacer=""
                fi

                output="$output$icon $description$spacer"
            fi
        done

        echo "$output"
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

path_pid="/home/user/.config/polybar/network-networkmanager.pid"

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
