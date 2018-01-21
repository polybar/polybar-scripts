# Script: ticker-bcheur

A script that displays the current Bitcoin Cash price.


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/ticker-bcheur]
type = custom/script
exec = ~/polybar-scripts/ticker-bcheur.sh
interval = 600
```
