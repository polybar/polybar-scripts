# Script: network-ipinfo.io

Shows your public IP address and country of origin retrieved from `ipinfo.io`.

![network-ipinfo.io](screenshots/1.png)


## Dependencies

* `curl`
* `jq`


## Configuration

The minimum interval of 60 seconds is important since free usage is limited to 50,000 API requests per month.


## Module

```ini
[module/network-ipinfo.io]
type = custom/script
exec = ~/.config/polybar/network-ipinfo.io.sh
interval = 60
```
