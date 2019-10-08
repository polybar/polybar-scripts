# Script: vpn-nordvpn-status

A small script that shows the status of NordVpn, with click-able actions that allow you to connect / reconnect. When connected it will display the City of the connection.

![vpn-nordvpn-status](screenshots/1.png)
![vpn-nordvpn-status](screenshots/2.png)


## Module

```ini
[module/vpn-nordvpn-status]
type = custom/script
exec = ~/polybar-scripts/vpn-nordvpn-status.sh
interval = 5
```
