#!/bin/sh
#
#   weather script, ~/.config/i3/openweathermap-smart.sh
#   usage: ./<path to>/openweathermap-smart.sh [options]
#           -f   exclude the forecast for changing weather
#           -s   exclude sunset and sunrise
#           -m   exclude the visible moon

#   adapted from https://github.com/polybar/polybar-scripts
#   created: 2022, December

#   integrate in …/polybar/config.ini
#	[[bar/polybar]]
#	type= custom/script
#	exec= ~/polybar-scripts/openweathermap-smart.sh
#	interval= 600

#	integrate in …/i3/config.toml:
#	[[block]]
#	block= "custom"
#	interval= 600
#	command= "~/.config/i3/openweathermap-smart.sh -s -f"
#	on_click= "xdg-open https://www.yr.no/en/forecast/graph/2-2940132"      # adapt your city-code


#   ─────────────────────── user provded prarameters ─────────────────────── 
KEY="<your openweathermap API key>"	# edit your openweathermap API key
UNITS="metric"
SYMBOL="°"          # example: °F, °C
#   edit the geolocation, or
#   remove to autolocate with https://location.services.mozilla.com/v1/geolocate?key=geoclue
LATITUDE=48.232; LONGITUDE=16.366   # Vienna
LATITUDE=50.822; LONGITUDE=12.928   # actual place
API="https://api.openweathermap.org/data/2.5"


#   ─────────────────────── functions ─────────────────────── 
round() {           # round $1 to $2 decimal places
    printf "%.${2:-0}f" "$1"
}

get_icon() {        #	select the fitting emoji/ icon
    #   $1 is the icon symbol, cf. https://openweathermap.org/weather-conditions#How-to-get-icon-URL
    #   $2 the probability, if provided
    case "$1" in
        01n|02n|03n)                    # in the night…
            if [ $1 == "01n" ]; then
                 icon="✨";             # clear night without Moon 🌃🏙
            else icon="☁️"              # standard night with some clouds, if Moon not visible
            fi
            if [ "$moon" = true ]; then # include moon, if desired
                elevation=$(echo "                      # good proxy of the Moon’s elevation
                    pi=  4* a(1); rad=pi/ 180;          # convert ° to rad 
                    jd=  $now/ 24/ 60/ 60- 10957.5;     # days since J2000 epoche
                    eps= 23.4263;                       # earth obliquity ε
                    angle=218.3162+ 13.176396* jd;
                    tx=  c(angle*rad); ty=s(angle*rad)*c(eps*rad); tz=s(angle*rad)*s(eps*rad);
                    lst= jd* (1+1/365.242189)+ 0.7790572733+ $LONGITUDE/ 360;   # local siderial time
                    tz* s($LATITUDE*rad)+ c($LATITUDE*rad)*(tx* c(lst*2*pi)+ ty* s(lst*2*pi))" | bc -l)  # sin of the Moon’s elevation
                if (( $(echo "$elevation > 0.01" | bc -l) )); then
                    elongation=$(echo "                 # Moon phase in hours
                        period=29.53058770576*60*60*24; # Moon’s synodic period
                        scale=0;                        # prepare for integer division
                        rem=($now- 500000)% period; 24* rem/ period" | bc -l)
                    if (( $(echo "$LATITUDE < 0.0" | bc -l) )); then
                        elongation=$((24- elongation))  # southern hemisphere
                    fi
                    case "$elongation" in
                        2|3|4)    icon="🌒";;           # right ascension in hours
                        5|6|7)    icon="🌓";;			# first quarter moon
                        8|9|10)   icon="🌔";;
                        11|12|13) icon="🌕";;			# full moon
                        14|15|16) icon="🌖";;
                        17|18|19) icon="🌗";;			# last quarter moon
                        20|21|22) icon="🌘";;
                        *)        icon="🌑";;			# new moon
                    esac
            fi; fi;;
        01d)     icon="☀️";;   # clear sky ☀️
        02d)     icon="🌤️";;   # few clouds
        03d)     icon="⛅️";;   # scattered clouds 🌦️⛅⛆☂️💧
        04d)     icon="🌥️️";;   # broken clouds
        04n)     icon="☁️";;
        09d|10d)
            if [ -n $2 ] && [ $2 -lt 50 ]; then
                 icon="🌦️"     # rain expected with small probability
			else icon="🌧️"     # rain
            fi;;
        09n|10n) icon="🌧️";;   # shower rain ⛈
        11*)     icon="🌩️";;   # thunderstorm ⚡🌩️🌩
        13d)     icon="🌨️";;   # snow
        13n)     icon="❄️";;
        50*)     icon="🌫️";;   # mist 🌫️🌫
        *)       icon="❔";;   # this should not happen
    esac
    echo $icon
}

#   ─────────────────────── script ─────────────────────── 
#   read the flags given
sun=true   # default to display sunrise and sunset
fc=true    # default to display the forecast
moon=true  # defalut to display the moon
while getopts sfm option; do
    case $option in
        s)  sun=false;;       # do not display sunrise and sunset if option ‘-s‘ is set.
        f)  fc=false;;        # do not display forecast if option ‘-f’ is set.
        m)  moon=false;;      # do not display the moon if the flag ‘-m’ is set.
    esac
done

#	grab the position
if [ ! -n "$LATITUDE" ] || [ ! -n "$LONGITUDE" ]; then
    location=$(curl -sf "https://location.services.mozilla.com/v1/geolocate?key=geoclue")
    if [ -n "$location" ]; then
        LATITUDE="$(echo "$location" | jq '.location.lat')"
        LONGITUDE="$(echo "$location" | jq '.location.lng')"
fi; fi

#	grab the weather data from API at openweatermap.com
current=$(curl -sf "$API/weather?appid=$KEY&lat=$LATITUDE&lon=$LONGITUDE&units=$UNITS")
forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$LATITUDE&lon=$LONGITUDE&units=$UNITS&cnt=1")

#	process the weather
if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_id=$(echo "$current" | jq -r ".weather[0].id")               # weather id
    current_desc=$(echo "$current" | jq -r ".weather[0].main")           # weather description
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")           # forecast icon
    current_temp=$(round $(echo "$current" | jq ".main.temp"))           # forecast temperature

    now=$(date +%s)		# ‘now’ used as a global variable
#	simple weather text
    STRING="$(get_icon "$current_icon") $current_desc $current_temp$SYMBOL"

#	forecast for changing weather conditions, if desired
    if [ "$fc" = true ]; then
        forecast_id=$(echo "$forecast" | jq -r ".list[].weather[0].id")      # forecast id
        forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")  # forecast icon
        forecast_temp=$(round $(echo "$forecast" | jq ".list[].main.temp"))  # forecast temperature
        forecast_pop=$(echo "$forecast" | jq ".list[].pop")                  # probability %
        forecast_pop=$(echo "scale=0; (100* $forecast_pop+ 0.5)/ 1" | bc)
        if ( [ $current_id -ge 700 ] && [ $forecast_id -lt 700 ] ) || ( [ $current_id -le 700 ] && [ $forecast_id -gt 700 ] ) || ( [ $current_temp -gt 0 ] && [ $forecast_temp -le 0 ] ) ; then
            if [ $forecast_pop -gt 0 ]; then
                probability=$(echo " ("$forecast_pop"%)")
            fi
            STRING="$(get_icon "$forecast_icon" "$forecast_pop") $forecast_temp$SYMBOL expected$probability"
    fi; fi

#	append sunset and sunrise, if desired
    if [ "$sun" = true ]; then
        sun_rise=$(echo "$current" | jq ".sys.sunrise")
        sun_set=$(echo "$current" | jq ".sys.sunset")
        if [ $sun_rise -gt 0 ] && [ $sun_set -gt 0 ]; then
            if [ $(date --date="22:05" +%s) -lt $now ] || [ $(($now+570)) -lt $sun_rise ]; then   # sunrise
               	tmp=$(echo $(date --date="@$sun_rise" +%k:%M))		# this removes padding blanks
                STRING="$STRING 🌄 $tmp"
            elif [ $now -lt $sun_set ] && [ $(($now+5000)) -gt $sun_set ]; then
                STRING="$STRING 🌇 $(date --date="@$sun_set" +%k:%M)"
    fi; fi; fi
    echo "$STRING"
else            # possibly no internet connection
    echo "❔"
fi
