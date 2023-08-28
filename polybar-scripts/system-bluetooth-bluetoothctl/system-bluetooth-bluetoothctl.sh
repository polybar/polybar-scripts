#!/bin/sh

bluetooth_print() {
    bluetoothctl | while read -r REPLY; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
            printf '#1'

            devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
            counter=0

            for device in $devices_paired; do
                device_info=$(bluetoothctl info "$device")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
                    device_address=$(echo "$device" | sed -r 's/[:]+/_/g')
                    device_battery=$(dbus-send --print-reply=literal --system --dest=org.bluez /org/bluez/hci0/dev_"$device_address" org.freedesktop.DBus.Properties.Get string:"org.bluez.Battery1" string:"Percentage" | sed 's/.*byte //')

                    if [ "$device_battery" -gt 90 ]; then
                        battery_icon="#21"
                    elif [ "$device_battery" -gt 60 ]; then
                        battery_icon="#22"
                    elif [ "$device_battery" -gt 35 ]; then
                        battery_icon="#23"
                    elif [ "$device_battery" -gt 10 ]; then
                        battery_icon="#24"
                    else
                        battery_icon="#25"
                    fi
                    if [ $counter -gt 0 ]; then
                        printf ", %s %s  %s%%" "$device_alias" "$battery_icon" "$device_battery"
                    else
                        printf " %s %s  %s%%" "$device_alias" "$battery_icon" "$device_battery"
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
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
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
