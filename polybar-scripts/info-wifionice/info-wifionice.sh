#!/bin/sh

wifionice=$(curl -sf https://iceportal.de/api1/rs/status)

if [ "$(echo "$wifionice" | jq .connection)" = "true" ]; then
    wifionice_speed=$(echo "$wifionice" | jq .speed)
    if [ "$wifionice_speed" -ne 0 ]; then
        wifionice_speed="$wifionice_speed km/h"
    else
        wifionice_speed=""
    fi

    station=$(curl -sf https://iceportal.de/api1/rs/tripInfo/trip | jq '[.[].stops[]? | select(.info.passed == false)][0]')

    station_name=$(echo "$station" | jq -r '.station.name')

    station_track=$(echo "$station" | jq -r '.track.actual')

    station_arrival=$(echo "$station" | jq -r '.timetable.scheduledArrivalTime')
    station_arrival=$(date --date="@$((station_arrival / 1000))" +%H:%M)

    station_delay=$(echo "$station" | jq -r '.timetable.arrivalDelay')
    if [ ! -z "$station_delay" ]; then
        station_delay=" %{F#d60606}($station_delay)%{F-}"
    else
        station_delay=""
    fi

    echo "# $station_arrival$station_delay - $station_name, Gl. $station_track - $wifionice_speed"
fi
