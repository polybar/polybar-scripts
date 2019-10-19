# Script: battery-combined-tlp

A shell script that shows the battery status.

It uses TLP and requires root privileges. Note that the icon doesn't change.

![battery-combined-tlp](screenshots/1.png)


## Dependencies

* `tlp`


## Configuration

You have to add the `tlp-stat` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /usr/bin/tlp-stat
```


## Module

```ini
[module/battery-combined-tlp]
type = custom/script
exec = ~/polybar-scripts/battery-combined-tlp.sh
interval = 10
```
