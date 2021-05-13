#!/bin/sh
set -e

echo "VPN $( mullvad status | cut -d' ' -f3 )"
