# Script: ticker-etheur

A script that displays the current Ethereum price.


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/ticker-etheur]
type = custom/script
exec = ~/polybar-scripts/ticker-etheur.sh
interval = 600
```
