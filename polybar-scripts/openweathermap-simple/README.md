# Script: openweathermap-simple

A weather script that displays some weather information.

It shows icons and temperatures for the current weather.

![openweathermap-simple](screenshots/1.png)


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
[module/openweathermap-simple]
type = custom/script
exec = ~/polybar-scripts/openweathermap-simple.sh
interval = 600
label-font = 3
```
### Using with other fonts

To use this with your own font, remove

```ini
label-font = 3
```

from the polybar configuration file.

After that, go to `openweathermap-simple.sh` and replace

```bash
echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL"
```

with

```bash
echo "%{T3}""$(get_icon "$weather_icon")" "%{T-}""$weather_temp$SYMBOL"
```

. This will use the 2nd font in your polybar config for the weather icon, but use your default font for the rest.
