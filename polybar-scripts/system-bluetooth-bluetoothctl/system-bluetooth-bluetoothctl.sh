#!/bin/sh

_status=$(bluetoothctl show | awk '/Powered/ {printf $2}')

bluetooth_print() {
    if [ "$_status" = "yes" ]; then
        _icon=''
        _label="$_icon"
        
        _obex_pid=$(pgrep -f obexftp -n)
        
        if [ -n "$_obex_pid" ]; then
            _devices=( $(ps -p $_obex_pid -o args --no-headers | awk 'match ($0, /([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})/) {printf substr($0, RSTART, RLENGTH)}') )
        else
            _devices=( $(bluetoothctl devices Connected | awk '{print $2}') )
        fi
        
        for _device in "${_devices[@]}"; do
            _info=$(bluetoothctl info $_device)
            _type=$(echo "$_info" | awk '/Icon/ {printf $2}')
            _name=$(echo "$_info" | awk '/Alias/ {for (i=2; i<NF; i++) printf $i " "; print $NF}')

            case $_type in
                audio*)
                    _icon=''
                    _battery=$(echo "$_info" | awk '/Battery/ {gsub(/[()]/,"",$4); printf $4}')
                    _label="$_icon $_name, $_battery%"
                    break
                    ;;
                *)
                    if [ -n "$_obex_pid" ]; then
                        _icon=''
                        _label="$_icon $_name"
                    elif [ -z "${_label:1}" ]; then
                        _icon=''
                        _label="$_icon $_name"
                    fi
                    ;;
            esac
        done
        echo "$_label"
    else
        echo ""
    fi
}

bluetooth_format() {
    _output=$(bluetooth_print)
    echo "%{T$1}${_output:0:2}%{T-}${_output:2}"
}

bluetooth_toggle() {
    if [ "$_status" = "yes" ]; then
        _devices=( $(bluetoothctl devices Connected | awk '{print $2}') )
        for _device in "${_devices[@]}"; do
            bluetoothctl disconnect $_device > /dev/null
        done
        bluetoothctl power off > /dev/null
    else
        bluetoothctl power on > /dev/null
        sleep 1
        _devices=( $(bluetoothctl devices Paired | awk '{print $2}') )
        for _device in "${_devices[@]}"; do
            bluetoothctl connect $_device > /dev/null
        done
    fi
}

case "$1" in
    --format)    bluetooth_format $2 ;;
    --toggle)    bluetooth_toggle ;;
    *)           bluetooth_print ;;
esac
