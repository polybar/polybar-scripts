#!/usr/bin/python

import subprocess

song = stdoutdata = subprocess.getoutput("mocp -Q %song")
album = stdoutdata = subprocess.getoutput("mocp -Q %album")
artist = stdoutdata = subprocess.getoutput("mocp -Q %artist")

print(song + " by " + artist + " on " + album)
