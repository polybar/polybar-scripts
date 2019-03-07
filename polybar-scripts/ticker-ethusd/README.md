# Script: ticker-ethusd

A script that displays the current Ethereum price.

## Dependencies

* `curl`
* `jq`

## Module

```ini
[module/ticker-ethusd]
type = custom/script
exec = ~/polybar-scripts/ticker-ethusd.sh
interval = 60
```
