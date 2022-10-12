#!/bin/sh

GITLAB_USERNAME=""
GITLAB_SERVER="https://gitlab.com"
GITLAB_ACCESS_TOKEN=""
HOURS_AGO="6"

available_projects=$(curl -sH "Private-Token: $GITLAB_ACCESS_TOKEN" \
  "$GITLAB_SERVER/api/v4/projects?membership=true" | jq '.[] | .id')
time=$(date -d "$HOURS_AGO hours ago" -Iseconds)

get_pipelines(){
  curl -sH "Private-Token: $GITLAB_ACCESS_TOKEN" \
    "$GITLAB_SERVER/api/v4/projects/$id/pipelines?username=$GITLAB_USERNAME&status=$1&updated_after=$time"| jq length
}

for id in $available_projects; do
  success=$((success + $(get_pipelines "success")))
  running=$((running + $(get_pipelines "running")))
  failed=$((failed +  $(get_pipelines "failed")))
done

echo "|%{F#7cfc00}$success%{F-}|%{F#ffff00}$running%{F-}|%{F#f00}$failed%{F-}|"
