# Script: info-wifionice

This script shows some information about the current ICE train of Deutsche Bahn. It requests the data from the local information portal and was obviously hacked in a train.

![info-wifionice](screenshots/1.png)

## Dependencies

* `jq`, and `curl` need to be in `$PATH`
* You have to be logged in to the local SSID `WIFIonICE`, see https://www.bahn.de/service/zug/wlan-im-zug.

## Module

```ini
[module/info-wifionice]
type = custom/script
exec = ~/polybar-scripts/info-wifionice.sh
interval = 10
```
