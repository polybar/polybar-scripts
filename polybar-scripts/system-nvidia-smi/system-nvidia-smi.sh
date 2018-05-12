#!/bin/sh

nvidia-smi --loop=10 --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print "# $1 %" }'
