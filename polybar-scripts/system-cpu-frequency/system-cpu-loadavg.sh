#!/bin/sh

cpupower frequency-info -fm | grep -oP '(?<=frequency: )([^ ]+ [^ ]+)'
