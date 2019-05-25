# Script: info-thinklight

A small script that displays the Thinklight state (ON/OFF) from ThinkPad ACPI driver.

![info-thinklight](screenshots/1.png)

## Module

```ini
[module/thinklight]
type = custom/script
exec = ~/polybar-scripts/info-thinklight/info-thinklight.sh
interval = 1
```
