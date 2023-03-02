# Script: { system-alltemps }

Display all HWMON temperatures. Show name for each sensor on toggle.

![system-alltemps](screenshots/temps.gif)


## Module

```ini
[module/system-alltemps]
type = custom/script
exec = ~/polybar-scripts/system-alltemps.sh
;interval = 5
format-prefix = "TEMP "
format-prefix-foreground = ${colors.primary}
tail = true
click-left = "kill -USR1 %pid%"
label=%output%
...
```
