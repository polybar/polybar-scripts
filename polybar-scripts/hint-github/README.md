# Script: hint-github

A small script that shows your GitHub notifications.

Generate a token at `GitHub Settings` > `Developer settings` > `Personal access tokens`.


## Dependencies

* `curl`
* `jq`


## Module

```
[module/hint-github]
type = custom/script
exec = ~/polybar-scripts/hint-github.sh
interval = 60
```
