#!/usr/bin/env bash

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -F 'string "' '/string|array/ {printf "%s",$2; next}{print ""}' | awk -F '"' '/artist/ {a=$2} /title/ {t=$2} END{print a " - " t}'
