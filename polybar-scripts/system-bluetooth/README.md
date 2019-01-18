# Script: system-bluetooth

Switch ON and OFF the Bluetooth using left click. While switching ON the script will automatically try to connect to a predefined Bluetooth device.

![system-bluetooth](screenshots/1.png)


## Dependencies

* `bluetoothctl`
* `bluez`


## Configuration

Set the id of your Bluetooth device in system-bluetooth.sh.

You can get the list of your connected Bluetooth devices and their ID using bluetoothctl.

The icon is from FontAwesome.
## Module

```ini
[module/bluetooth]
type = custom/ipc
hook-0 = ~/polybar-scripts/system-bluetooth.sh
hook-1 = ~/polybar-scripts/system-bluetooth.sh start
initial = 2
click-left = polybar-msg -p %pid% hook bluetooth 1
```
