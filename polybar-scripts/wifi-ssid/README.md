# Script: wifi-ssid

A shell script that shows the wifi ssid connected.

Displays the name of the current WiFi network in the Polybar. Updates the network name every 10 seconds and displays the result in the format defined in the Polybar configuration. It's useful for having a quick look at the name of the WiFi network you're connected to.


## Module

```ini
[module/wifi-shell]
type = custom/script
exec = ~/polybar-scripts/wifi-ssid.sh

interval = 10

label = %output%
format = <label>
```
