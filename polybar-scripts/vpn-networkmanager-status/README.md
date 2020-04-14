# Script: vpn-networkmanager-status

A simple script that shows the name of the VPN started via NetworkManager.

![vpn-networkmanager-status](screenshots/1.png)


## Module

```ini
[module/vpn-networkmanager-status]
type = custom/script
exec = ~/polybar-scripts/vpn-networkmanager-status.sh
interval = 10
```
