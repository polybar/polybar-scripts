# Script: network-openwrt-status

Print stats from OpenWrt router. Such as signal levels, sms count and traffic bandwidth.

Written for Microdrive Tandem-4GT-OEM modem, but can be adopted to work with all OpenWrt routers.

![network-openwrt-status](screenshots/1.png)


## Dependencies

* `python-requests`


## Configuration

Just insert your router ip and credentials into heading of script.


## Module

```ini
[module/network-openwrt-status]
type = custom/script
exec = ~/polybar-scripts/network-openwrt-status.py
interval = 5
```
