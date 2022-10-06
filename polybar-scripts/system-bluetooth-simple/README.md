# Script: system-bluetooth-simple

A minimalistic Bluetooth module that shows if _any_ device is currently connected. This is useful for checking if devices such as wireless headphones are connected.

![simple-bluetooth-module](screenshots/1.png)

## Dependencies

This module only uses `bluetoothctl`.

## Module

```ini
[module/bluetooth-simple]
type = custom/script
exec = ~/.config/polybar/bluetooth-simple.sh
interval = 5
```
