# Script: openweathermap-autolocation

A weather script that displays some weather information. It determines your
approximate location using Mozilla Location Services. It shows icons,
temperatures and text for the current weather.

Change these values:
```
KEY=""
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


[module/openweathermap-detailed]
type = custom/script
exec = ~/polybar-scripts/openweathermap-autolocation.sh
interval = 600
label-font = 3
```
