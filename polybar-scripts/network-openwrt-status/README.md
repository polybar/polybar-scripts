# Script: network-openwrt-status

Print stats from OpenWrt router. Such as signal levels, sms count and traffic bandwidth.

Written for Microdrive Tandem-4GT-OEM modem, but can be adopted to work with all OpenWrt routers.

![screenshot](screenshots/1.png)


## Dependencies

* python3
* python-requests


## Configuration

Just insert your router ip and credentials to [luci.py](luci.py)

## Module

```ini
[module/luci]
type = custom/script
exec = ~/.config/polybar/scripts/network-openwrt-status/network-openwrt-status.py
interval = 3
...
```
