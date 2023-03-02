#!/bin/sh

TEMPS=""
TOGGLED=0
PID=0

toggle() {
    TOGGLED=$(( (TOGGLED + 1) % 2 ))

    if [ "$PID" -ne 0 ]; then
        kill $PID >/dev/null 2>&1
    fi
}

temps(){ 
    for i in /sys/class/hwmon/hwmon*/temp*_input;
    do  
        TEMP=$(cat "$i")
        TEMP=$(( TEMP/1000 ))
        TEMPS="${TEMPS}${TEMP}°C "
    done
    echo "$TEMPS"
}

verboose_temps(){
    for i in /sys/class/hwmon/hwmon*/temp*_input;
    do  
        LABELFILE=$(echo "$i" | sed 's/input/label/')
        NAMEFILE=$(echo "$i" | sed 's/temp.*/name/')
        if [ -f "$LABELFILE" ]; then
            NAME=$(cat "$LABELFILE")
        elif [ -f "$NAMEFILE" ]; then
            NAME=$(cat "$NAMEFILE")
        else
            NAME="?"
        fi
        TEMP=$(cat "$i")
        TEMP=$(( TEMP/1000 ))
        TEMPS="${TEMPS}${NAME}:${TEMP}°C "
    done
    echo "$TEMPS"
}

trap "toggle" USR1

while true; do
    TEMPS=""
    if [ $TOGGLED -eq 0 ]; then
        temps
    else
        verboose_temps
    fi
    sleep 1 &
    PID=$!
    wait
done