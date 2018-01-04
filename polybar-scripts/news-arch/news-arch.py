#!/usr/bin/python

import feedparser
from subprocess import call
import re
import textwrap

d = feedparser.parse("https://www.archlinux.org/feeds/news/")

for f in range(0, 1):
    print(d.entries[f].title)
    xy = d.entries[f].title
