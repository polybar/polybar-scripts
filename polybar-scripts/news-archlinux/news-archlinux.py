#!/usr/bin/python
import feedparser

d = feedparser.parse("https://www.archlinux.org/feeds/news/")
print(d.entries[0].title)
print(d.entries[1].title)
