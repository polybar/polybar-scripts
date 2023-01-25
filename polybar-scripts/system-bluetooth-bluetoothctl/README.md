# Script: system-bluetooth-bluetoothctl

A shell script which displays information about the current bluetooth connection.

Use the toggle option to power on the controller and try to connect to all paired devices or to disconnect all connections and turn off the controller.

If there are several connections, then one is selected in the following order:
1) sending file, newest obexftp process
2) audio headset
3) device, first in the list

![bluetooth-statuses](screenshots/statuses.png)


## Dependencies

* `bluetoothctl`
* `bluez-deprecated, obexftp (optional)`


## Configuration

Use the `set-alias` feature of `bluetoothctl` to customize your device names.

To send file with obexftp use:
```Shell
# check with bluetoothctl devices Connected
MAC_ADDR=<your device mac address>
CHANNEL=$(sdptool search --bdaddr $MAC_ADDR OPUSH | awk '/Channel/ {printf $2}')
obexftp -S -H -U none -b $MAC_ADDR -B $CHANNEL -p /path/to/send
```


## Module

```ini
[module/bluetooth]
type = custom/script
exec = ~/polybar-scripts/system-bluetooth-bluetoothctl.sh
tail = true
interval = 2
click-left = ~/polybar-scripts/system-bluetooth-bluetoothctl.sh --toggle &
click-right = blueman-manager &
...
```

You can also change the icon font with --format by specifying your font number.
For example, to use font-1:
```ini
exec = ~/polybar-scripts/system-bluetooth-bluetoothctl.sh --format 2
```
