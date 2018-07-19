# Script: info-todotxt

A script that shows todo.txt items due. The first column shows items due today, and the second column shows items due this week (including today).

![todotxt](screenshots/1.png)


## Module

```ini
[module/info-todotxt]
type = custom/script
exec = ~/polybar-scripts/info-todotxt.sh
interval = 60
```
