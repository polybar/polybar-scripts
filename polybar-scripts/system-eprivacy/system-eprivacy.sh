#!/bin/sh
# shellcheck disable=SC2034

eprivacy_status () {
    grep status /proc/acpi/ibm/lcdshadow | awk '{ print $2 }'
}

eprivacy_print () {
    if [ "$(eprivacy_status)" = 0 ]; then
        echo "#1"
    else
        echo "#2"
    fi
}

eprivacy_watch () {
    eprivacy_print

    inotifywait -q -m -e modify /proc/acpi/ibm/lcdshadow | while read -r "event" ; do
        eprivacy_print
    done
}

eprivacy_toggle () {
    if [ "$(eprivacy_status)" = 0 ]; then
        echo 1 | sudo tee /proc/acpi/ibm/lcdshadow > /dev/null
    else
        echo 0 | sudo tee /proc/acpi/ibm/lcdshadow > /dev/null
    fi
}

case "$1" in
    --toggle)
        eprivacy_toggle
        ;;
    *)
        eprivacy_watch
        ;;
esac
