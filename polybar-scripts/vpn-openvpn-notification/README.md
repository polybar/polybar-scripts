# Script: vpn-openvpn-notification

A script that shows if OpenVPN is running and which configuration file it uses.
If you want to see also the VPN-Status if there is no open connection you can use the vpn-openvpn-status module from this repository.

![vpn-openvpn-notification](screenshots/1.png)


## Configuration

* The configuration files must have an extension, e.g. `.ovpn`.
* The configuration files must be stored in a directory, e.g. `/etc/openvpn/conf.d`.

Launch OpenVPN with the following command:

```
openvpn --daemon --auth-nocache --cd "/etc/openvpn/conf.d" --config "UK-Southampton.ovpn"
```


## Module

```ini
[module/vpn-openvpn-notification]
type = custom/script
exec = ~/polybar-scripts/vpn-openvpn-notification.sh
interval = 5
```
