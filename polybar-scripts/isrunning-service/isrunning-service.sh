#!/bin/sh

print_status() {
    if [ "$(systemctl is-active "$UNIT")" = "active" ]; then
        echo "#1"
    else
        echo "#2"
    fi
}

UNIT="bluetooth.service"


print_status

journalctl --follow -o cat --since now --unit $UNIT | while read -r; do
    print_status
done
