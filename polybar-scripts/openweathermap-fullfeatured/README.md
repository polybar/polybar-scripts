# Script: openweathermap-fullfeatured

A weather script that shows a lot of information. It shows icons and temperatures for the current weather and the 3 hour forecast. It displays information about the next sunrise or sunset.

Change these values:
```
KEY=""
CITY=""
UNITS="metric"
SYMBOL="°"
```


## Dependencies

* OpenWeatherMap-Key - [available here](https://openweathermap.org/appid)
* [weather-icons](https://github.com/erikflowers/weather-icons)


## Module

```
[module/openweathermap-fullfeatured]
type = custom/script
exec = ~/polybar-scripts/openweathermap-fullfeatured.sh
interval = 600
```
