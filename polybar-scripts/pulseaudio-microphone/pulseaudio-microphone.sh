#!/bin/sh

#
# Prints the default microphone status (muted or unmuted). Uses PulseAudio.
#

# Global variables
DISABLED_COLOR="#777" # Color when the mic is off.
ENABLED_INDICATOR="#1" # Indicator when the mic is on.
DISABLED_INDICATOR="#2" # Indicator when the mic is off.

check_status() {
  MUTED=$(pacmd list-sources | awk '/*/,EOF {print}' | awk '/muted/ {print $2; exit}')

  if [ "$MUTED" = "yes" ]; then
    echo "%{F$DISABLED_COLOR}$DISABLED_INDICATOR"
  else
    echo "$ENABLED_INDICATOR"
  fi
}

listen() {
  pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
      check_status
    fi
  done
}

toggle_status() {
  MUTED=$(pacmd list-sources | awk '/*/,EOF {print}' | awk '/muted/ {print $2; exit}')
  DEFAULT_SOURCE=$(pacmd list-sources | awk '/*/,EOF {print $3; exit}')

  if [ "$MUTED" = "yes" ]; then
    pacmd set-source-mute "$DEFAULT_SOURCE" 0
  else
    pacmd set-source-mute "$DEFAULT_SOURCE" 1
  fi
}

case "$1" in
  --toggle)
    toggle_status
    ;;
  *)
    check_status
    listen
    ;;
esac

