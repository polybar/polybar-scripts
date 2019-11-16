# Script: vpn-wireguard-wg

A script that shows the status of a chosen Wireguard connection.

![vpn-wireguard-wg](screenshots/1.png)
![vpn-wireguard-wg](screenshots/2.png)


## Configuration

You have to add the `wg` and `wg-quick` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /usr/bin/wg
user ALL=(ALL) NOPASSWD: /usr/bin/wg-quick
```

## Module

```ini
[module/vpn-wireguard-wg]
type = custom/script
exec = ~/polybar-scripts/vpn-wireguard-wg.sh
interval = 5
click-left = ~/polybar-scripts//vpn-wireguard-wg.sh --toggle &
```
