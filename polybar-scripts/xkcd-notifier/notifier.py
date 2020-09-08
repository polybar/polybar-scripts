#!/usr/bin/env python3

import requests
from sys import argv

latest_file = "latest"
prefix = "#"
read = False

help = """xkcd-notifier: Display the current XKCD comic number, and show if there are any new ones.

Usage:
	-h, --help	Display this message
	--read		Mark the current comic as read
	-p <prefix>	Set the prefix to put before the comic number
	-f <file>	Location of the file xkcd-notifier stores the latest checked comic and status in
"""

skip = False
for i in range(1, len(argv)):
	if skip:
		skip = False
		continue

	if len(argv) > i + 1:
		if argv[i] == "-f":
			latest_file = argv[i + 1]
			skip = True

		if argv[i] == "-p":
			prefix = argv[i + 1]
			skip = True

	elif argv[i] == "--read":
		read = True

	elif argv[i] == "-h" or argv[i] == "--help":
		print(help)
		exit()
	
	else:
		print("Unknown option, try using --help to see valid options")
		exit()

what = 0

def useFile(doc, manner, write):
	manners = ['r', 'a', 'w', 'w+']
	if manner in manners:
		f = open(doc, manner)
		if manner == 'r':
			doc = f.read()
			f.close()
			return doc
		else:
			f.write(write)
			f.close()
	else:
		return "Invalid manner"


latest = int(useFile(latest_file, 'r', '')[0:4])

while True:
	status = requests.get('https://www.xkcd.com/' + str(latest + 1) + '/').status_code

	if status == 200:
		latest += 1
		useFile(latest_file, 'w', str(latest) + 'Unread')

	elif status == 404:
		toPrint = ""

		if useFile(latest_file, 'r', '')[4:] == 'Unread':
			toPrint += "New: "
	
		if read:
			toPrint = ""
			useFile(latest_file, 'w', str(latest) + 'Read')
		
		toPrint += str(latest)
		print(prefix + " " + toPrint)
		break

