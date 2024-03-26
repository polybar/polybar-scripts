#!/bin/sh
# shellcheck disable=SC2034

UNIT="docker.service"

journalctl --follow -o cat --unit $UNIT | while read -r line; do
    if [ "$(systemctl is-active "$UNIT")" = "active" ]; then
        echo "#1"
    else
        echo "#2"
    fi
done
