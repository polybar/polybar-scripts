# Script: inbox-reddit

A script that shows if there are unread mails in your Reddit inbox.

Type Reddit JSON URL from [reddit.com/prefs/feeds/](https://www.reddit.com/prefs/feeds/). Click `your inbox` > `unread messages` > `JSON` and copy the link.


## Dependencies

* `curl`
* `jq`


## Module

```
[module/inbox-reddit]
type = custom/script
exec = ~/polybar-scripts/inbox-reddit.sh
interval = 60
```
