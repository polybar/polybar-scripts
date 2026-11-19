#!/bin/sh

active_icon='#1'
inactive_icon='#2'
power_off_icon='#1'
# <if battery more than>:<icon>
battery_icons='90:#21 60:#22 35:#23 10:#24 0:#25'

update_line_pattern='Device\|Controller\|#'

bluetooth_tail() {
    bluetooth_print
    bluetoothctl | grep --line-buffered $update_line_pattern | while read -r _; do
        bluetooth_print
    done
}

bluetooth_print() {
    if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            printf '%s' $active_icon
        else
            printf '%s' $power_off_icon
        fi

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        counter=0

        for device in $devices_paired; do
            device_info=$(bluetoothctl info "$device")

            if echo "$device_info" | grep -q "Connected: yes"; then
                if [ $counter -gt 0 ]; then
                    printf ", "
                else
                    printf " "
                fi
                device_print "$device_info"
                counter=$((counter + 1))
            fi
        done

        printf '\n'
    else
        echo $inactive_icon
    fi
}

device_print() {
    device_info=$1

    device_output=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
    device_battery_percent=$(echo "$device_info" | grep "Battery Percentage" | awk -F'[()]' '{print $2}')

    if [ -n "$device_battery_percent" ]; then
        max_level_found=0
        for icon_config in $battery_icons; do
            min_level=$( echo "$icon_config" | awk -F ':' '{print $1}' )
            if [ "$device_battery_percent" -gt "$min_level" ] \
            && [ "$min_level" -gt "$max_level_found" ]; then
                device_battery_icon=" $( echo "$icon_config" | awk -F ':' '{print $2}' )"
                max_level_found=$min_level
            fi
        done

        device_output="$device_output$device_battery_icon $device_battery_percent%"
    fi

    printf "%s" "$device_output"
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
        bluetooth_tail
        ;;
esac
