#!/usr/bin/env bash
# Script that gets Thinklight state from ThinkPad ACPI driver.

if [ "$(</sys/devices/platform/thinkpad_acpi/leds/tpacpi::thinklight/brightness)" == "0" ]; then
  echo "#1" # OFF message
else
  echo "#2 Thinklight" # ON message
fi
