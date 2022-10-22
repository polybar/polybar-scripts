#!/bin/sh

# To change city change the LOCATION_CODE.
LOCATION_CODE='38d35340a098212bc3ae7aa6ff89ce95a7eed769997999f8ad0804d2f3ccd560'
# ==============================================================================


info_to_icon() {    
    case $1 in
        'Sunny')
            echo '☀ ';;
        'Night Clear')
            echo ' ';;
        'Mostly Sunny')
            echo ' ';;
        'Partly Cloudy')
            echo ' ';;
        'Partly Cloudy Night')
            echo ' ';;
        'Mostly Cloudy')
            echo ' ';;
        'Mostly Cloudy Night')
            echo ' ';;
        'Cloudy')
            echo ' ';;
        'Scattered Showers')
            echo ' ';;
        'Rain')
            echo ' ';;
        *)
            echo "$1";;
        esac
}


# weather_scraper.py needs to be in same dir as this script.
json=$(python weather_scraper.py "$LOCATION_CODE")
weather=$(echo "$json" | jq '.location.forecasts' | jq '.[0].weather')


# forecast 1
tmp1=$(echo "$weather" | jq -r '.[0].temperature')
tmp1_num=$(echo "$tmp1" | tr -d '°')

info1=$(echo "$weather" | jq -r '.[0].info')
icon1=$(info_to_icon "$info1")

# forecast 2
tmp2=$(echo "$weather" | jq -r '.[1].temperature')
tmp2_num=$(echo "$tmp2" | tr -d '°')

info2=$(echo "$weather" | jq -r '.[1].info')
icon2=$(info_to_icon "$info2")

# Set the arrow for the corresponding diff temps
if [ "$tmp1_num" -lt "$tmp2_num" ]; 
then
    tmp_diff='↗ '
elif [ "$tmp1_num" -eq "$tmp2_num" ];
then
    tmp_diff='→ '
else
    tmp_diff='↘ '
fi

# output for polybar
echo "$icon1 $tmp1 $tmp_diff $icon2 $tmp2"

