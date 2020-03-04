# Script: vpn-networkmanager-status

Simple script that shows the name of the VPN started via NetworkManager

![skeleton](screenshots/1.png)


## Configuration

Start a VPN configuration via nmcli with the following command

`nmcli connection up <vpn-name>`

## Module

```ini
[module/vpn-networkmanager-status]
type = custom/script
exec = ~/polybar-scripts/vpn-networkmanager-status.sh
interval =
...
```
