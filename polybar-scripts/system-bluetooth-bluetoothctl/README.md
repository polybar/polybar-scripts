# Script: system-bluetooth-bluetoothctl

A shell script which displays the status of bluetooth and the paired devices.

Use the toggle option to power on the controller and try to connect to all paired devices or to disconnect all connections and turn off the controller.

![system-bluetooth-bluetoothctl](screenshots/1.png)


## Dependencies

* `bluetoothctl`


## Configuration

Use the `set-alias` feature of `bluetoothctl` to customize your device names.


## Module

```ini
[module/system-bluetooth-bluetoothctl]
type = custom/script
exec = ~/polybar-scripts/system-bluetooth-bluetoothctl.sh
tail = true
click-left = ~/polybar-scripts/system-bluetooth-bluetoothctl.sh --toggle &
```
