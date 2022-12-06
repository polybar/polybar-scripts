# Script: network-huawei-modem

Print stats from Huawei modem sticks. Such as signal levels, sms count and traffic bandwidth.

Tested with E3372h-320, but should work with others.

![screenshot](screenshots/1.png)


## Dependencies

* python3
* [Salamek/huawei-lte-api](https://github.com/Salamek/huawei-lte-api)


## Configuration

Just insert your modem ip and credentials into heading of script.

## Module

```ini
[module/huawei]
type = custom/script
exec = ~/.config/polybar/scripts/network-huawei-modem/network-huawei-modem.py
interval = 3
...
```
