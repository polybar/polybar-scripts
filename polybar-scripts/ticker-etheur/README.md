# Script: ticker-btceur

A script that displays the current Ethereum price.


## Dependencies

* `curl`
* `jq`


## Module

```
[module/ticker-etheur]
type = custom/script
exec = ~/polybar-scripts/ticker-etheur.sh
interval = 600
```
