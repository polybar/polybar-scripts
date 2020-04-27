#!/bin/bash

bluetooth_print() {
    bluetoothctl | while read -r; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
            printf '#1'

            devices_paired=$(echo paired-devices | bluetoothctl | sed -n '/paired-devices/,$p' | grep Device | cut -d ' ' -f 2)
            counter=0

            echo "$devices_paired" | while read -r line; do
                device_info=$(echo "info $line" | bluetoothctl)

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

                    if [ $counter -gt 0 ]; then
                        printf ", %s" "$device_alias"
                    else
                        printf " %s" "$device_alias"
                    fi

                    counter=$((counter + 1))
                fi
            done

            printf '\n'
        else
            echo "#2"
        fi
    done
}

bluetooth_toggle() {
    if echo show | bluetoothctl | grep -q "Powered: no"; then
        echo "power on" | bluetoothctl >> /dev/null
        sleep 1

        devices_paired=$(echo paired-devices | bluetoothctl | sed -n '/paired-devices/,$p' | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            echo "connect $line" | bluetoothctl >> /dev/null
        done
    else
        devices_paired=$(echo paired-devices | bluetoothctl | sed -n '/paired-devices/,$p' | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            device_info=$(echo "info $line" | bluetoothctl)

            if echo "$device_info" | grep -q "Connected: yes"; then
                echo "disconnect $line" | bluetoothctl >> /dev/null
            fi
        done

        echo "power off" | bluetoothctl >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
