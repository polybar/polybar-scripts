# Script: info-wakatime

![info-wakatime](screenshots/1.png)

Display your daily coding time from wakatime.


## Dependencies

* `curl`
* `jq`
* obviously a wakatime.com account


## Module

```ini
[module/info-wakatime]
type = custom/script
exec = ~/polybar-scripts/info-wakatime.sh
interval = 60
```
