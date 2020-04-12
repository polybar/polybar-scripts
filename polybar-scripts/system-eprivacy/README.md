# Script: system-eprivacy

A small script to manage the ePrivacy state for ThinkPads.

![system-eprivacy](screenshots/1.png)


## Dependencies

* `inotify-tools`


## Configuration

You have to add the `/usr/bin/tee /proc/acpi/ibm/lcdshadow` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL = NOPASSWD: /usr/bin/tee /proc/acpi/ibm/lcdshadow
```


## Module

```ini
[module/system-eprivacy]
type = custom/script
exec = ~/polybar-scripts/system-eprivacy.sh
tail = true
click-left = ~/polybar-scripts/system-eprivacy.sh --toggle &
```
