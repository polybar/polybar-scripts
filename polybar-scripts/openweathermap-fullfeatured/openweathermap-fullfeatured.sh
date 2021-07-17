#!/bin/sh

get_icon() {
    case $1 in
        # Icons for weather-icons
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03*) icon="";;
        #04*) icon="";;
        #09d) icon="";;
        #09n) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11d) icon="";;
        #11n) icon="";;
        #13d) icon="";;
        #13n) icon="";;
        #50d) icon="";;
        #50n) icon="";;
        #*) icon="";

        # Icons for Font Awesome 5 Pro
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03d) icon="";;
        #03n) icon="";;
        #04*) icon="";;
        #09*) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11*) icon="";;
        #13*) icon="";;
        #50*) icon="";;
        #*) icon="";

		# Icons for Nerd Fonts
		01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03d) icon="";;
        03n) icon="";;
        04d) icon="";;
        04n) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
		temp) icon="";;
		pressure) icon="";;
		humidity) icon="";;
		wind) icon="煮";;
		sunrise) icon=" ";;
		sunset) icon=" ";;
        *) icon="??";

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

KEY=""
CITY=""
# UNITS should be "metric" or "imperial"
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
    #forecast=$(curl -sf "$API/forecast?appid=$KEY&$CITY_PARAM&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        #forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

## these can be changed for correct trend line icon, or left as is for no forecast comparison
#if [ -n "$current" ] && [ -n "$forecast" ]; then
if [ -n "$current" ]; then
    #current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    #current_icon=$(echo "$current" | jq -r ".weather[0].icon")

	## These get the numbers from the returns data and cuts of the decimal place without rounding
    temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    icon=$(echo "$current" | jq -r ".weather[0].icon")
	feels_like=$(echo "$current" | jq ".main.feels_like" | cut -d "." -f 1)
    temp_min="$(echo "$current" | jq ".main.temp_min" | cut -d "." -f 1)"
    temp_max="$(echo "$current" | jq ".main.temp_max" | cut -d "." -f 1)"
    pressure="$(echo "$current" | jq ".main.pressure")"
    humidity="$(echo "$current" | jq ".main.humidity")"
	wind_speed="$(echo "$current" | jq ".wind.speed" | cut -d "." -f 1)"
	wind_dir=$(echo "$current" | jq ".wind.deg")

    #forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    #forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")

	## if you want to use trend lines, it would be a good idea to add these icons to mapping in the icon function
    #if [ "$current_temp" -gt "$forecast_temp" ]; then
    #    trend="免"
    #elif [ "$forecast_temp" -gt "$current_temp" ]; then
    #    trend="勤"
    #else
    #    trend="勉"
    #fi


    sunrise=$(echo "$current" | jq ".sys.sunrise")
    sunset=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)
	sunrise_time="$(get_duration "$((sunrise-now))")"
	sunset_time="$(get_duration "$((sunset-now))")"

    if [ "$sunrise" -gt "$now" ]; then
        daytime="  $(get_duration "$((sunrise-now))")"
    elif [ "$sunset" -gt "$now" ]; then
        daytime="  $(get_duration "$((sunset-now))")"
    else
        daytime="  $(get_duration "$((sunrise-now))")"
    fi

	## The first output line is the original that compares the current temp to the forecasted temp
	## The second output line is just the current conditions and uses a lot more data
    #echo "$(get_icon "$current_icon") $current_temp$SYMBOL$trend $(get_icon "$forecast_icon") $forecast_temp$SYMBOL $daytime"
	echo "$(get_icon "$icon") $temp$SYMBOL/$temp_min$SYMBOL/$temp_max$SYMBOL $(get_icon "humidity") $humidity $(get_icon "wind") $wind_speed $(get_icon "sunrise") $sunrise_time $(get_icon "sunset") $sunset_time"
fi
