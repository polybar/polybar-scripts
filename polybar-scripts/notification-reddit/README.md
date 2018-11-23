# Script: notification-reddit

A script that shows if there are unread mails in your Reddit inbox.

Type Reddit JSON URL from [reddit.com/prefs/feeds/](https://www.reddit.com/prefs/feeds/). Click `your inbox` > `unread messages` > `JSON` and copy the link.

![notification-reddit](screenshots/1.png)


## Dependencies

* `curl`
* `jq`


## Module

```ini
[module/notification-reddit]
type = custom/script
exec = ~/polybar-scripts/notification-reddit.sh
interval = 60
```
