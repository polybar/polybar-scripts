# Script: vpn-openvpn-status

A script that shows if OpenVPN is running and which configuration file it uses.

![vpn-openvpn-status](screenshots/1.png)
![vpn-openvpn-status](screenshots/2.png)


## Configuration

* The configuration files must have an extension, e.g. `.ovpn`.
* The configuration files must be stored in a directory, e.g. `/etc/openvpn/conf.d`.

Launch OpenVPN with the following command:

```
openvpn --daemon --auth-nocache --cd "/etc/openvpn/conf.d" --config "UK-Southampton.ovpn"
```


## Module

```ini
[module/vpn-openvpn-status]
type = custom/script
exec = ~/polybar-scripts/vpn-openvpn-status.sh
interval = 5
```
