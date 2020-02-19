# Script: netowrk-usage

This script gets the total amount of data transfered since boot time.

## Dependencies
* net-tools
* `grep`
* `bc`

## Configuration
The script can show output in two formats: 
* down/up: shows both download and upload values and is chosen by passing `split` to the script
* total: shows the sum of dowload and upload values and is chosen by passing `total` to the script


## Module

```ini
[module/network-usage]
type = custom/script
exec = ~/polybar-scripts/network-usage.sh <format>
interval = 30
```
