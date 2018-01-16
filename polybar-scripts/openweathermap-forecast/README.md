# Script: openweathermap-forecast

A weather script that displays a weather forecast.

It shows icons and temperatures for the current weather and the 3 hour forecast.

If `CITY` is left empty, the location is retrieved via the Mozilla Location API.  

Change these values:
```
KEY=""
CITY=""
UNITS="metric"
SYMBOL="°"
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


[module/openweathermap-forecast]
type = custom/script
exec = ~/polybar-scripts/openweathermap-forecast.sh
interval = 600
label-font = 3
```
