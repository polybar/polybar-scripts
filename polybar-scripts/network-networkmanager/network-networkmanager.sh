#!/bin/sh

network_print() {
    connection_list=$(nmcli -t -f name,type,device,state connection show --order name --active 2>/dev/null | grep -v ':bridge:')
    counter=0

    if [ -n "$connection_list" ] && [ "$(echo "$connection_list" | wc -l)" -gt 0  ]; then
        echo "$connection_list" | while read -r line; do
            description=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 1)
            type=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 2)
            device=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 3)
            state=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 4)

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

                    description="$description ($speed)"
                elif [ "$type" = "bluetooth" ]; then
                    icon="#3"
                fi
            elif [ "$state" = "activating" ]; then
                icon="#4"
            elif [ "$state" = "deactivating" ]; then
                icon="#5"
            fi

            if [ $counter -gt 0 ]; then
                printf "  %s %s" "$icon" "$description"
            else
                printf "%s %s" "$icon" "$description"
            fi

            counter=$((counter + 1))
        done

        printf "\n"
    else
        echo "#6"
    fi
}

trap exit INT

while true; do
    network_print

    timeout 60s nmcli monitor | while read -r; do
        network_print
    done &

    wait
done
