# Script: ticker-forex

A small script that displays current exchange rates.

Rates are ECB reference rates (updated once per working day) from the keyless
[AllRatesToday](https://allratestoday.com) endpoint, which uses the same response
format as the old exchangeratesapi.io API. Exchange rates by AllRatesToday.


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
