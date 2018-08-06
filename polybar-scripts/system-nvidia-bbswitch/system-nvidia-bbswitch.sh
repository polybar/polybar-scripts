#!/bin/sh

if grep -q ON /proc/acpi/bbswitch; then
      echo "# Active"
else
    echo "# Inactive"
fi
