# Script: vpn-expressvpn-status

A small script that shows the status of ExpressVPN. Includes a `--toggle` option
to connect/disconnect.

![connected](screenshots/connected.png)
![disconnected](screenshots/disconnected.png)

## Dependencies

The [ExpressVPN client](https://www.expressvpn.com/vpn-software/vpn-linux)

## Module

```ini
[module/vpn-expressvpn-status]
type = custom/script
exec = ~/polybar-scripts/vpn-expressvpn-status.sh
click-left = ~/polybar-scripts/vpn-expressvpn-status.sh --toggle
interval = 5
```
