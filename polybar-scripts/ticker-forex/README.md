# Script: ticker-forex

A small script that displays current exchange rates.


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/ticker-forex]
type = custom/script
exec = ~/polybar-scripts/ticker-forex.sh
interval = 600
```
