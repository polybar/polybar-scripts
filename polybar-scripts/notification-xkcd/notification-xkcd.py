#!/usr/bin/env python3

import requests
from sys import argv

latest_file = "/home/user/polybar-scripts/notification-xkcd-latest"
icon = "#"


read = False
if len(argv) > 1:
	if argv[1] == "read":
		read = True


def useFile(doc, mode, write):
	f = open(doc, mode)
	if mode == 'r':
		doc = f.read()
		f.close()
		return doc
	else:
		f.write(write)
		f.close()

try:
	latest = int(useFile(latest_file, 'r', '')[0:4])
except FileNotFoundError:
	useFile(latest_file, 'x', "2350")
	latest = 2350

newComic = False
while True:
	try:
		status = requests.get('https://www.xkcd.com/' + str(latest + 1) + '/').status_code
	except requests.exceptions.ConnectionError:
		status = 404

	if status == 200:
		latest += 1
		newComic = True

	elif status == 404:
		toPrint = ""

		if useFile(latest_file, 'r', '')[4:] == 'Unread':
			toPrint = "New: "
	
		if read:
			toPrint = ""
			useFile(latest_file, 'w', str(latest) + 'Read')
		elif newComic:
			useFile(latest_file, 'w', str(latest) + 'Unread')
			toPrint = "New: "
		
		toPrint += str(latest)
		print(icon + toPrint)
		break

