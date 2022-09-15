# Script: info-trainwifi

When connected to an in-train Wi-Fi network, this script shows the next stop, arrival time, and other information. The data is sourced from the local train information portal.
Obviously, this script was hacked over the course of several train journeys 🚄.

![German ICE](screenshots/1.png)
![French Nomad Krono+](screenshots/2.png)

## Supported Trains and Wi-Fi Networks

| Country | Train | SSID | More Information |
|---------|-------|-------|------------|
| Germany | ICE   | `WIFIonICE` or `WIFI@DB` | https://www.bahn.de/service/zug/wlan-im-zug |
| France  | Nomad Krono+ | `NormandieTrainConnecte` | https://www.ter.sncf.com/normandie/services-contacts/services/krono-plus |

## Dependencies

* `bc` ([the GNU basic calculator](https://www.gnu.org/software/bc/)) needs to be in `PATH`
* You have to be logged in to one of the local SSIDs shown above.

## Module

```ini
[module/info-trainwifi]
type = custom/script
exec = ~/polybar-scripts/info-trainwifi.sh
interval = 10
```
