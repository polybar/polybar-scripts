#!/usr/bin/env bash
set -euo pipefail

echo "VPN $( mullvad status | cut -d' ' -f3 )"
