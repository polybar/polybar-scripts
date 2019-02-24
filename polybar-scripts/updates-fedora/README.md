# Script: updates-fedora

A script that shows if there are updates for Fedora or `dnf` based distributions.

![updates-fedora](screenshots/1.png)


## Configuration

You have to add the `dnf` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/dnf
```

## Module

```ini
[module/updates-fedora]
type = custom/script
exec = ~/polybar-scripts/updates-fedora.sh
interval = 600
```
