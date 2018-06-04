#!/bin/sh

# You can use several --query-gpu= values.
# Use nvidia-smi --help-query-gpu for a complete list and description.
# The most notable are:
# fan.speed
# memory.used
# memory.total
# driver_version
# power.draw
# pstate

# If you don't need custom labelling use this instead:
# nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader

nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print "GPU",""$1"","%"}'
