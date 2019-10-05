# Script: system-thinklight

A small script that displays the Thinklight state from ThinkPad ACPI driver.

![system-thinklight](screenshots/1.png)


## Module

```ini
[module/system-thinklight]
type = custom/script
exec = ~/polybar-scripts/system-thinklight.sh
interval = 10
```
