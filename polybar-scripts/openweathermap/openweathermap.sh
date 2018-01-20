#!/bin/sh

KEY="2705ba057f6d9c0297d0ee2f35356739"
CITY="" # Leave empty to retrieve location via the Mozilla Location API
UNITS="metric"
SYMBOL="°"
SHOW_FORECAST=false # Set to true to show forecast
SHOW_WEATHER_ICON=true # Set to false to hide weather icon (not for forecast)

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";
    esac

    echo $icon
}

get_duration() {
    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" -u +%H:%M;;
        *) date --date="@$1" -u +%H:%M;;
    esac
}

round() {
    xargs printf "%.0f"
}

weather_url_prefix="http://api.openweathermap.org/data/2.5/weather?appid=$KEY&units=$UNITS"
forecast_url_prefix="http://api.openweathermap.org/data/2.5/forecast?appid=$KEY&units=$UNITS&cnt=1"

print_weather() {
    location_params="$1"

    weather="$(curl -sf "$weather_url_prefix&$location_params")" || exit
    weather_temp=$(echo "$weather" | jq '.main.temp' | round)
    weather_desc=$(echo "$weather" | jq -r '[.weather[].description] | join(", ")')

    if [ "$SHOW_WEATHER_ICON" = true ]; then
        echo -n "$(get_icon "$weather_icon") " 
    fi

    echo "$weather_desc", "$weather_temp$SYMBOL"
}

print_forecast() {
    location_params="$1"

    weather="$(curl -sf "$weather_url_prefix&$location_params")" || exit
    weather_temp=$(echo "$weather" | jq '.main.temp' | round)
    forecast="$(curl -sf "$forecast_url_prefix&$location_params")" || exit
    forecast_temp=$(echo "$forecast" | jq '.list[].main.temp' | round)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[].icon")

    if [ "$weather_temp" -gt "$forecast_temp" ]; then
        trend=""
    elif [ "$forecast_temp" -gt "$weather_temp" ]; then
        trend=""
    else
        trend=""
    fi

    sun_rise=$(echo "$weather" | jq ".sys.sunrise")
    sun_set=$(echo "$weather" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_rise" -gt "$now" ]; then
        daytime=" $(get_duration "$(("$sun_rise"-"$now"))")"
    elif [ "$sun_set" -gt "$now" ]; then
        daytime=" $(get_duration "$(("$sun_set"-"$now"))")"
    else
        daytime=" $(get_duration "$(("$sun_rise"-"$now"))")"
    fi

    echo "$(get_icon "$weather_icon") $weather_temp$SYMBOL  $trend  $(get_icon "$forecast_icon") $forecast_temp$SYMBOL   $daytime"
}

if [ -n "$CITY" ]; then
    location_params="id=$CITY"
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue) || exit

    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"
    location_params="lat=$location_lat&lon=$location_lon"
fi

if [ "$SHOW_FORECAST" = true ]; then 
    print_forecast "$location_params" 
else
    print_weather "$location_params"
fi