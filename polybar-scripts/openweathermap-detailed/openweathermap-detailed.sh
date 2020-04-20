#!/bin/sh

get_icon() {
    case $1 in
        # Replace with weather icons from your font
        # Icon code descriptions can be found at https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2
        01d) icon="#1";;
        01n) icon="#2";;
        02d) icon="#3";;
        02n) icon="#4";;
        03*) icon="#5";;
        04*) icon="#6";;
        09d) icon="#7";;
        09n) icon="#8";;
        10d) icon="#9";;
        10n) icon="#10";;
        11d) icon="#11";;
        11n) icon="#12";;
        13d) icon="#13";;
        13n) icon="#14";;
        50d) icon="#15";;
        50n) icon="16";;
        *) icon="#17";

    esac

    echo $icon
}

KEY=""
CITY=""
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "$(get_icon "$weather_icon")" "$weather_desc", "$weather_temp$SYMBOL"
fi
