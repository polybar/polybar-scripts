# Script: notification-github

A small script that shows your GitHub notifications.


## Dependencies

* `curl`
* `jq`


## Configuration

Generate a token at `GitHub Settings` > `Developer settings` > `Personal access tokens`.
Make sure you have it saved as an env variable named GITHUB_TOKEN.


## Module

```ini
[module/notification-github]
type = custom/script
exec = ~/polybar-scripts/notification-github.sh
# Adjust interval based on github rate limit
# https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting
interval = 60
click-left = xdg-open 'https://github.com/notifications' &
```
