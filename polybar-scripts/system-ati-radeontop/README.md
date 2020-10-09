# Script: system-ati-radeontop

A script that outputs gpu usage for amd cards using radeontop.

![system-ati-radeontop](screenshots/1.png)


## Dependencies

* `radeontop`: Can be obtained from [clbr/radeontop](https://github.com/clbr/radeontop)


## Module

```ini
[module/system-ati-radeontop]
type = custom/script
exec = ~/polybar-scripts/system-ati-radeontop.sh
interval = 3
```
