#!/bin/sh

bluetooth_devices() {
    bluetooth_version=$(bluetoothctl --version | cut -d ' ' -f 2)
    version_command='devices Paired'
    new_version=5.65

    version_compare=$(awk 'BEGIN{print "'$bluetooth_version'"<="'new_version'"}')

    if [ "$version_compare" -eq 0 ]; then
        version_command='paired-devices'
    fi

    echo $(bluetoothctl $version_command | grep Device | cut -d ' ' -f 2)
}

bluetooth_print() {
    bluetoothctl | while read -r; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
            printf '#1'

	    devices_paired=$(bluetooth_devices)
            counter=0

            for device in $devices_paired; do
                device_info=$(bluetoothctl info "$device")

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
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

	devices_paired=$(bluetooth_devices)
	echo "$devices_paired" | while read -r line; do
		bluetoothctl connect "$line" >> /dev/null
        done
    else
	devices_paired=$(bluetooth_devices)
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
