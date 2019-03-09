#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
  echo "%{u#55aa55}#1 $(nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2)%{u-}"
else
  echo "%{F#FF0000}%{u#FF0000}#1 VPN DISCONNECTED%{u-}%{F-}"
fi

