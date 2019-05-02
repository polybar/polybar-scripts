#!/bin/sh

if [ "$(systemctl is-active docker.service)" = "active" ]; then
    echo "#1"
else
    echo "#2"
fi
