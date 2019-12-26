# Script: einfo-thermine

This script reports the current hashrate (in MH/s) for your ethermine account.


## Dependencies

* `python-requests`


## Module

```ini
[module/ethermine]
type = custom/script
exec = ~/polybar-scripts/ethermine.sh
interval = 60
```
