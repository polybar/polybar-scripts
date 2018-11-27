# Script: openweathermap-detailed

A weather script that displays some weather information.

It shows icons, temperatures and text for the current weather. The script can be easily modified to display a forecast. Look at the commented out line.

![openweathermap-detailed](screenshots/1.png)


## Dependencies

* [OpenWeatherMap-Key](https://openweathermap.org/appid)
* [weather-icons](https://github.com/erikflowers/weather-icons)
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
[module/openweathermap-detailed]
type = custom/script
exec = ~/polybar-scripts/openweathermap-detailed.sh
interval = 600
label-font = 3
```
