# Script: ticker-crypto

A script that displays current Cryptocurrency quotes like Bitcoin.

![ticker-crypto](screenshots/1.png)


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/ticker-crypto]
type = custom/script
exec = ~/polybar-scripts/ticker-crypto.sh
interval = 600
```
