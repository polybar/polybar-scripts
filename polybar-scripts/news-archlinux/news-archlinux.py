#!/usr/bin/python
from feedparser import parse

URL = 'https://www.archlinux.org/feeds/news/'
ENTRIES = 1

[print(x.title) for x in parse(URL).entries[:ENTRIES]]
