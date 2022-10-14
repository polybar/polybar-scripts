#!/bin/sh

spacex_launch=$(curl -sf https://api.spacexdata.com/v5/launches/next)

if [ -n "$spacex_launch" ]; then
    spacex_precision=$(echo "$spacex_launch" | jq -r '.date_precision' )
    spacex_timestamp=$(echo "$spacex_launch" | jq -r '.date_unix' )
    spacex_duration=$((spacex_timestamp - $(date +%s)))

    if [ "$spacex_precision" = "hour" ] && [ "$spacex_duration" -lt 43200 ] && [ "$spacex_duration" -gt 0 ]; then
        echo "# $(date +"%H:%M" -u --date @$spacex_duration)"
    else
        echo ""
    fi
else
    echo ""
fi
