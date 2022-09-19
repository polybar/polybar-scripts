#!/bin/sh

icon="#"

current_wifi=$(iwgetid -r)
if [ "$current_wifi" = "NormandieTrainConnecte" ]; then
    # Obtain route info. Bail out if it cannot be obtained or if the response
    # is not valid JSON (based on jq's exit code).
    if ! { circulation=$(curl --silent --fail https://wifi.normandie.fr/router/api/train/circulation); } then
        echo "$icon In-train portal unreachable"
        exit 0
    fi
    if ! { echo "$circulation" | jq --exit-status > /dev/null 2>&1; } then
        echo "$icon In-train portal unreachable"
        exit 0
    fi

    # In the list of stops on the current route, future stops are those which
    # have an "arrival" key (the first station only has "departure"), and which
    # either have a "progress" key showing 0% progress or which lack the
    # "progress" key entirely. Stops are ordered according to the itinerary, so
    # pick the first matching one to obtain the immediate next station.
    station=$(echo "$circulation" | jq '[.stopList.stops[] |
        select(
            .arrival and (has("progress") | not) or .progress.progressPercentage == 0
        )][0]')
    
    # get name and track (as soon as it's available)
    station_name=$(echo "$station" | jq -r '.location.name')
    station_track=$(echo "$station" | jq -r '.track.number?')
    if [ "$station_track" != "null" ]; then
        station_name="$station_name, V. $station_track"
    fi
    
    # compute current delay in minutes based on "date" and "realDate"
    scheduled_arrival=$(echo "$station" | jq -r '.arrival.date')
    actual_arrival=$(echo "$station" | jq -r '.arrival.realDate')
    delay_minutes="($(date +%s -d "$actual_arrival")-$(date +%s -d "$scheduled_arrival"))/60"
    delay_minutes=$(echo "$delay_minutes" | bc)

    # pretty-print arrival and delay
    scheduled_arrival_pretty=$(date --date="$scheduled_arrival" +%H:%M)
    delay_pretty=""
    if [ "$delay_minutes" -ne 0 ]; then
        delay_pretty=" %{F#d60606}(+$delay_minutes)%{F-}"
    fi

    gps=$(curl --silent --fail https://wifi.normandie.fr/router/api/train/gps)

    # convert train speed from m/s to km/h
    speed_mps=$(echo "$gps" | jq .speed)
    speed_kph=$(echo "scale=0; $speed_mps * 3.6" | bc)
    speed_kph_pretty="${speed_kph%.*} kph"

    echo "$icon $scheduled_arrival_pretty$delay_pretty - $station_name - $speed_kph_pretty"
else
    echo ""
fi
