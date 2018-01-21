# Script: notification-github

A small script that shows your GitHub notifications.

Generate a token at `GitHub Settings` > `Developer settings` > `Personal access tokens`.


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/notification-github]
type = custom/script
exec = ~/polybar-scripts/notification-github.sh
interval = 60
```
