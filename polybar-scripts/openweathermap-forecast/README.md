# Script: openweathermap-forecast

A weather script that displays a weather forecast.

It shows icons and temperatures for the current weather and the 3 hour forecast.


## Dependencies

* [OpenWeatherMap Key](https://openweathermap.org/appid)
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
[module/openweathermap-forecast]
type = custom/script
exec = ~/polybar-scripts/openweathermap-forecast.sh
interval = 600
```
