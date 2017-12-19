# Script: battery-combined-tlp

In order to support dual batteries and benefit from TLP's more precise information about them (percentage is computed with respect to capacity).
Note that the icon doesn't change (as you may have guessed with the minimal code provided).


## Dependencies

* `tlp`

You may need to add `tlp-stat` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/tlp-stat
```


## Module

```
[module/battery-combined-tlp]
type = custom/script
exec = ~/polybar-scripts/battery-combined-tlp.sh
interval = 10
```
