# Script: openweathermap-smart

A weather script to display actual weather information.

It shows icons, temperatures and text for the current weather.

## Dependencies

* [OpenWeatherMap Key](https://openweathermap.org/appid)
* `jq`
* weather-icons are most probably available in your fonts

## Configuration

If LATITUDE or LONGIGUDE are empty, the location is retrieved via the Mozilla Location API.

Change these values:

```
KEY=""
UNITS="metric"
SYMBOL="°"
LATITUDE=48.111
LATITUDE=16.333
```

## Module
```
[module/openweathermap-detailed]
type = custom/script
exec = ~/polybar-scripts/openweathermap-smart.sh
interval = 600
```
