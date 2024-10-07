#!/bin/sh

spacex_launch=$(curl -sf "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?lsp__name=SpaceX&status__ids=1&limit=1")

if [ -n "$spacex_launch" ]; then
    spacex_precision=$(printf "%s" "$spacex_launch" | jq -r '.results[0].net_precision.abbrev' )

    if [ "$spacex_precision" = "HR" ] || [ "$spacex_precision" = "MIN" ] || [ "$spacex_precision" = "SEC" ]; then
        spacex_timestamp=$(date +"%s" --date "$(printf "%s" "$spacex_launch" | jq -r '.results[0].net' )")
        spacex_duration=$((spacex_timestamp - $(date +%s)))
        if [ "$spacex_duration" -lt 43200 ] && [ "$spacex_duration" -gt 0 ]; then
            echo "# $(date +"%H:%M" -u --date @$spacex_duration)"
        else
            echo ""
        fi
    else
        echo ""
    fi
else
    echo ""
fi
