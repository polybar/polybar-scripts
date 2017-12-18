# Script: ticker-btc

A script that displays the current bitcoin price.


## Dependencies

* `curl`
* `jq`


## Module

```
[module/{ name }]
type = custom/script
exec = ~/polybar-scripts/ticker-btc.sh
interval = 600
```
