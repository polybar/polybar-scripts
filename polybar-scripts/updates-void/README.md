# Script: updates-void

A script that shows if there are updates for Void Linux.


## Configuration

You have to add the `xbps-install` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/xbps-install
```


## Module

```ini
[module/updates-void]
type = custom/script
exec = ~/polybar-scripts/updates-void.sh
interval = 20
```
