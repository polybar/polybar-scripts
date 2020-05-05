# Script: info-gitlab-pipelines

Displays the number of succeeded, running and failed gitlab-pipelines triggered by a user.

![info-gitlab-pipelines](screenshots/1.png)


## Dependencies

* jq


## Configuration

Insert the specific server-url, username and your GitLab token (Settings -> Access Token).


## Module

```ini
[module/info-gitlab-pipelines]
type = custom/script
exec = ~/polybar-scripts/info-gitlab-pipelines.sh
interval = 30
...
