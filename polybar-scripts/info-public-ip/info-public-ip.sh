#!/bin/sh
Public_IP=$(curl ipecho.net/plain 2> /dev/null)
echo "# $Public_IP"
