# Script: info-nicehash

This script reports the number of online rigs and daily profit of your nicehash account


## Dependencies

* `python-requests`

## Instructions

Update nh\_config.py with your details

## Module

```ini
[module/info-nicehash]
type = custom/script
exec = ~/polybar-scripts/info-nicehash/nicehash_status.py
interval = 60
```
