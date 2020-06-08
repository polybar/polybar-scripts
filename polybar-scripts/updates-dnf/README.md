# Script: updates-dnf

A script that shows if there are updates for dnf-based distributions like Fedora.

![updates-dnf](screenshots/1.png)


## Configuration

You have to add the `dnf` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/dnf updateinfo -q --list
```

## Module

```ini
[module/updates-dnf]
type = custom/script
exec = ~/polybar-scripts/updates-dnf.sh
interval = 600
```
