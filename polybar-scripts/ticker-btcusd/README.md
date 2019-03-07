# Script: ticker-btcusd

A script that displays the current Bitcoin price.

## Dependencies

* `curl`
* `jq`

## Module

```ini
[module/ticker-btcusd]
type = custom/script
exec = ~/polybar-scripts/ticker-btcusd.sh
interval = 60
```
