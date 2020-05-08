# Script: vpn-expressvpn-status

A small script that shows the status of ExpressVPN.

It includes a `--toggle` option to connect/disconnect.

![vpn-expressvpn-status](screenshots/1.png)
![vpn-expressvpn-status](screenshots/2.png)


## Dependencies

* [`ExpressVPN client`](https://www.expressvpn.com/vpn-software/vpn-linux)


## Module

```ini
[module/vpn-expressvpn-status]
type = custom/script
exec = ~/polybar-scripts/vpn-expressvpn-status.sh
click-left = ~/polybar-scripts/vpn-expressvpn-status.sh --toggle &
interval = 10
```
