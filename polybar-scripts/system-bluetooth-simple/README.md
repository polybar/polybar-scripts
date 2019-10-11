# Script: system-bluetooth-simple

A small bluetooth icon to activate bluetooth and see the current status

![off](screenshots/off.png) ![on](screenshots/on.png) ![conneted](screenshots/connected.png)

## Dependencies

* `bluetoothctl`
* Hack Nerd Font


## Module

```ini
[module/bluetooth]
type = custom/script
click-left = ~/polybar-scripts/bluetooth_ON-OFF.sh
exec = ~/polybar-scripts/bluetooth_connected.sh
label = %output%
interval = 10
```
