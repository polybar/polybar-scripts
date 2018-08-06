# Script: notification-mattermost

A small script that shows your unread Mattermost messages and mentions.


## Dependencies

* `curl`
* `jq`


## Configuration

Generate a token at `Account Settings` > `Security` > `Personal Access Tokens`. You have to enable tokens in your server config.


## Module

```ini
[module/notification-mattermost]
type = custom/script
exec = ~/polybar-scripts/notification-mattermost.sh
interval = 60
```
