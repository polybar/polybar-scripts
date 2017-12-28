#!/usr/bin/env python3
# -*- coding: utf8 -*-
"""
bat

========================================
oooo    oooo               .
`888   .8P'              .o8
 888  d8'     .ooooo.  .o888oo  .oooo.
 88888[      d88' `88b   888   `P  )88b
 888`88b.    888   888   888    .oP"888
 888  `88b.  888   888   888 . d8(  888
o888o  o888o `Y8bod8P'   "888" `Y888""8o
               @nilsu.org
=== Copyright (C) 2017  Dakota Walsh ===
"""

# imports
import os
import sys

# constants
AC = '/sys/class/power_supply/AC'
BAT0 = '/sys/class/power_supply/BAT0'
BAT1 = '/sys/class/power_supply/BAT1'
bat0 = ''
bat1 = ''
bat0Max = ''
bat1Max = ''

f = open(os.path.join(AC, 'online'), 'r')
ac = f.readline()
f.close()

try:
    f = open(os.path.join(BAT0, 'energy_full'), 'r')
    bat0Max = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT0, 'energy_now'), 'r')
    bat0 = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT0, 'charge_full'), 'r')
    bat0Max = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT0, 'charge_now'), 'r')
    bat0 = f.readline()
    f.close()
except:
    pass

try:
    # get battery charge amounts
    f = open(os.path.join(BAT1, 'energy_full'), 'r')
    bat1Max = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT1, 'energy_now'), 'r')
    bat1 = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT1, 'charge_full'), 'r')
    bat1Max = f.readline()
    f.close()
except:
    pass

try:
    f = open(os.path.join(BAT1, 'charge_now'), 'r')
    bat1 = f.readline()
    f.close()
except:
    pass

# check that battery values were found
if (bat0 == ''):
    sys.exit("battery 0 not found")
if (bat1 == ''):
    sys.exit("battery 1 not found")
if (bat0Max == ''):
    sys.exit("battery 0 not found")
if (bat1Max == ''):
    sys.exit("battery 1 not found")

# convert to percent
bat0Percent = (int(bat0) / int(bat0Max)) * 100
bat1Percent = (int(bat1) / int(bat1Max)) * 100

batPercent = (bat0Percent + bat1Percent) / 2

# printing prefix
if (int(ac) != 0):
    prefix = '#1'

    if (int(batPercent) >= 97):
        print(prefix)

else:
    if (int(batPercent) >= 85):
        prefix = '#21'
    elif (int(batPercent) >= 60):
        prefix = '#22'
    elif (int(batPercent) >= 35):
        prefix = '#23'
    elif (int(batPercent) >= 10):
        prefix = '#24'
    else:
        prefix = '#25'

    print(prefix + "  " + str(int(batPercent)) + " %")
