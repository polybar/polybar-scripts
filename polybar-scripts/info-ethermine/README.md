# Script: info-ethermine

This script reports the current hashrate (in MH/s) for your ethermine account.


## Dependencies

* `python-requests`


## Module

```ini
[module/info-ethermine]
type = custom/script
exec = ~/polybar-scripts/info-ethermine.sh
interval = 60
```
