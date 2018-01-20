# Script: openweathermap

A weather script. 

It can show icons, temperatures and text for the current weather, or it can
show a forecast and sunrise/sunset times.


Change these values:
```
KEY=""
CITY="" # Leave empty to retrieve location via the Mozilla Location API
UNITS="metric"
SYMBOL="°"
SHOW_FORECAST=false # Set to true to show forecast instead
SHOW_WEATHER_ICON=true # Set to false to hide weather icon (not for forecast)
```


## Dependencies

* [OpenWeatherMap-Key](https://openweathermap.org/appid)
* [weather-icons](https://github.com/erikflowers/weather-icons)
* `jq`


## Module

```
[bar/polybar]
...
font-2 = Weather Icons:size=12;1
...


[module/openweathermap]
type = custom/script
exec = ~/polybar-scripts/openweathermap.sh
interval = 300
label-font = 3
```
