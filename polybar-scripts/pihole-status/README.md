# Script: pihole-status

A script to remotely disable/enable Pi-Hole's blocking. Displays the current status and toggle status when clicked.

Depends on `curl` and `jq`.

## Module

Update the `pihole-status.sh` with your Pi-Hole instance's hostname and API key. You may also customize the on/off label, refresh time, as well as the amount of time to disable Pi-Hole for (by default, 300 seconds).

```ini
[module/pihole-status]
type = custom/script
exec = ~/polybar-scripts/pihole-status.sh
tail = true
click-left = kill -USR1 %pid%
```

## How this script works

This script uses `tail` to keep a long-running instance of the application, which Polybar uses the last outputted line as label. It fetches the new status with curl every 10 seconds (configurable) and outputs the on or off label based on the current status read without the JSON response with jq.

When the script is clicked, a `USR1` signal is sent to it with `kill`, and it runs the `toggle`. This updates the status with curl and prints the current status, and restarts the refresh loop.

This design was required to have both auto-refreshing and updating on click.
