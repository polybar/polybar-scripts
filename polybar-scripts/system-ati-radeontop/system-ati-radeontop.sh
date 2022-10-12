#!/bin/sh

radeontop -d - -i 1 | grep --line-buffered -oP "gpu \K\d{1,3}"
