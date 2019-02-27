# Script: vpn-wireguard-wg

A script that shows status of chosen Wireguard connection and allows easy control it

![up](screenshots/1.png) ![down](screenshots/2.png)


## Configuration

```sh
CONFIG_PATH=~/wg/wireguard.conf

SHOW_NAME=false

CONNECTED_ICON="#1 VPN:"
CONNECTED_TEXT="up"

DISCONNECTED_ICON="#2 VPN:"
DISCONNECTED_TEXT="down"
```

## Module

```ini
[module/vpn-wireguard-wg]
type = custom/script
exec = ~/polybar-scripts/vpn-wireguard-wg.sh
click-left = ~/polybar-scripts//vpn-wireguard-wg.sh --toggle
interval = 5
```
