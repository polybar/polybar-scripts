#!/bin/sh
usbtoserial_print() {
    devices=$(find /dev/ -name "ttyUSB*")

    counter=0
    for device in $devices; do
        device_name=$(udevadm info --query=property --export --name "$device" | grep ID_MODEL_FROM_DATABASE | cut -d "'" -f 2 | cut -d ' ' -f 1)

        if [ $counter -gt 0 ]; then
            printf ", %s" "$device_name"
        else
            printf "#1 %s" "$device_name"
        fi

        counter=$((counter + 1))
    done

    printf '\n'
}

path_pid="/tmp/polybar-usbtoserial.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            usbtoserial_print

            sleep 30 &
            wait
        done
        ;;
esac
