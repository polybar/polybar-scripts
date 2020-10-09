#!/bin/sh

echo "$(sudo radeontop -l 1 -d - | grep -o -e "gpu[^.]*" | sed "s/gpu //")%" || echo ""
