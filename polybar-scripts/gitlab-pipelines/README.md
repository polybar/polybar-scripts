# Script: gitlab-pipelines
Displays the number of succeeded, running and failed gitlab-pipelines triggered by a user.

![screenshot](screenshots/gitlab-screenshot.png)
## Dependencies
* jq

## Configuration
Insert the specific server-url, username and your gitlab token (Settings -> Access Token):
Also you can define the time you want to search pipelines. As default, it lists all pipelines from now - 6 hours.

```sh
GITLAB_USERNAME="johndoe"
GITLAB_SERVER="https://gitlab.com"
GITLAB_ACCESS_TOKEN="434wsds43"
HOURS_AGO="6"
```

## Module

```ini
[module/gitlab-pipelines]
type = custom/script
exec = ~/polybar-scripts/gitlab-pipelines.sh
interval = 20
...
```
