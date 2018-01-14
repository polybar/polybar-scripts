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
CITY=""
UNITS="metric"
SYMBOL="°"

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$CITY&units=$UNITS")
# weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")

weather_desc=$(echo "$weather" | jq -r ".weather[].description")
weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
weather_icon=$(echo "$weather" | jq -r ".weather[].icon")

echo "$(get_icon "$weather_icon")" "$weather_desc", "$weather_temp$SYMBOL"
