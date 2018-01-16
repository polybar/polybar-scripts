#!/bin/sh

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

KEY=""
UNITS="metric"
SYMBOL="°"

LOC_URL='https://location.services.mozilla.com/v1/geolocate?key=geoclue'

if ! location_json="$(curl -sf "$LOC_URL")"; then
	exit
fi

lat="$(echo "$location_json" | jq '.location.lat')"
lon="$(echo "$location_json" | jq '.location.lng')"

weather_url="http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$lat&lon=$lon&units=$UNITS"

# Don't update output if weather fetch fails
if ! weather="$(curl -sf "$weather_url")"; then
	exit
fi

weather_desc=$(echo "$weather" | jq -r ".weather[].description")
weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
weather_icon=$(echo "$weather" | jq -r ".weather[].icon")

echo "$(get_icon "$weather_icon")" "$weather_desc", "$weather_temp$SYMBOL"
