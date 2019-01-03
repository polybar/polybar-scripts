#!/bin/sh

# this script installs the polybar module rss

destdir=${HOME}/.config/polybar/scripts/news
polybar_conf=${HOME}/.config/polybar/config

install -d "${destdir}"
install -b -m 644 ./*.conf ./*.py ./*.tpl rss.feeds "${destdir}"
install -m 554 news.sh "${destdir}"

if [ -f "${polybar_conf}" ]; then
    cat polybar.conf >> "${polybar_conf}"
else
    echo "Add the following lines to your polybar configuration:"
    cat polybar.conf
fi
