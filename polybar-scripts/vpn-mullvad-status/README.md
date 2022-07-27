# Script: vpn-mullvad-status

A script that shows if Mullvad is connected, connecting or disconnected.

![vpn-mullvad-status](screenshots/1.png)
![vpn-mullvad-status](screenshots/2.png)


## Module

```ini
[module/polybar-mullvad-status]
type = custom/script
exec = ~/polybar-scripts/vpn-mullvad-status.sh
interval = 5
```

For more advanced polybar modules to display and control Mullvad VPN connection state and tunnel settings, take a look at [totoroot/polybar-modules-mullvad](https://github.com/totoroot/polybar-modules-mullvad).
