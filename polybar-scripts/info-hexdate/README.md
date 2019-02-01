# Script: info-hexdate

Print the current date in a hex format.

![skeleton](screenshots/hex-date.png)

This was inspired by [one root to rule them all hex calendar 2019](https://linux.pictures/projects/one-root-to-rule-them-all-hex-calendar-2019).


## Module

```ini
[module/info-hexdate]
type = custom/script
exec = ~/polybar-scripts/info-hexdate.sh
interval = 60
```
