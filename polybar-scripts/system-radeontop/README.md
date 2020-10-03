# Script: system-radeontop

A script that outputs gpu usage using radeontop.

![system-radeontop](screenshots/1.png)

## Dependencies

* `radeontop`: Can be obtained from ![this repo](https://github.com/clbr/radeontop)

## Module

```ini
[module/system-radeontop]
type = custom/script
exec = ~/polybar-scripts/system-radeontop.sh
interval = 3
```
