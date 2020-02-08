# Script: vpn-wireguard-wg

A script that shows the status of a chosen Wireguard connection.

![vpn-wireguard-wg](screenshots/1.png)
![vpn-wireguard-wg](screenshots/2.png)

(The icon used in the screenshots is ﱾ = nf-mdi-shield_half_full = fc7e)

## Configuration

You have to add the `wg` and `wg-quick` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /usr/bin/wg
user ALL=(ALL) NOPASSWD: /usr/bin/wg-quick
```

See comments in `vpn-wireguard-wg.sh` for tips on how to adapt the script for your setup.

## Module

Pass the wireguard config/interface you want to monitor as the first argument to the script, e.g. `myvpn`. The path to the config file must be configured in the script.

```ini
[module/vpn-wireguard-wg]
type = custom/script
exec = ~/polybar-scripts/vpn-wireguard-wg.sh myvpn
interval = 5
click-left = ~/polybar-scripts//vpn-wireguard-wg.sh myvpn --toggle &
```
