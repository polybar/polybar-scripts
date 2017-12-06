#!/bin/sh

pid=$(pgrep -x "dropbox")

isRunning() {
    if pgrep -x "dropbox" > /dev/null; then
        return 0
    else
        return 1
    fi
}

if [ $# -gt 0 ]; then
    case "$1" in
        toggle)
            if isRunning; then
                kill "$pid";
                exit 0
            fi
            dropbox &
        ;;
        *)
            echo "error: wrong argument";
            exit 1
        ;;
    esac
fi

if isRunning; then
    echo "#1"
    exit 0
fi
echo "#2"
exit 0
