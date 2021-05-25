#!/bin/sh

nmodules="$(pactl list modules short | grep -c noisetorch)"
[ "$nmodules" = 0 ] && echo "" || echo ""

