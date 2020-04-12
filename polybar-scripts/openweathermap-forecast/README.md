# Script: openweathermap-forecast

A weather script that displays a weather forecast.

It shows icons and temperatures for the current weather and the 3 hour forecast.


## Dependencies

* [OpenWeatherMap Key](https://openweathermap.org/appid)
* [weather-icons](https://github.com/erikflowers/weather-icons) or [Font Awesome 5 Pro](https://fontawesome.com/changelog/latest)
* `jq`


## Configuration

If `CITY` is left empty, the location is retrieved via the Mozilla Location API. `CITY` can either be a city ID (e.g. ID of Berlin is `2950159`), city name (e.g. `Berlin`) or city name + country code (e.g. `Berlin,DE`).

Change these values:

```sh
KEY=""
CITY=""
UNITS="metric"
SYMBOL="°"
```


## Module

```ini
[bar/polybar]
...
font-2 = Weather Icons:size=12;1
...
```

```ini
[module/openweathermap-forecast]
type = custom/script
exec = ~/polybar-scripts/openweathermap-forecast.sh
interval = 600
label-font = 3
```
