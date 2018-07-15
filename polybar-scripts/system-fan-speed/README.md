# Script: system-fan-speed

A shell script which displays the fan speed.


## Dependencies

* `lm_sensors`
* `bc`


## Module

```ini
[module/system-fan-speed]
type = custom/script
exec = ~/polybar-scripts/system-fan-speed.sh
interval = 10
```
