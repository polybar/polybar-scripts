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

get_duration() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" -u +%H:%M;;if [ "$current_temp" -gt "$forecast_temp" ]; then
        # trend-down
        trend="#18"
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        # trend-up
        trend="#19"
    else
        # trend-nochange
        trend="#20"
    fi
        *) date --date="@$1" -u +%H:%M;;
    esac

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

    current=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
    forecast=$(curl -sf "$API/forecast?appid=$KEY&$CITY_PARAM&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")


    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend=""
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend=""
    else
        trend=""
    fi


    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_rise" -gt "$now" ]; then
        # sunrise
        daytime="#21 $(get_duration "$((sun_rise-now))")"
    elif [ "$sun_set" -gt "$now" ]; then
        # sunset
        daytime="#22 $(get_duration "$((sun_set-now))")"
    else
        # sunrise
        daytime="#21 $(get_duration "$((sun_rise-now))")"
    fi

    echo "$(get_icon "$current_icon") $current_temp$SYMBOL  $trend  $(get_icon "$forecast_icon") $forecast_temp$SYMBOL   $daytime"
fi
