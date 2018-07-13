#!/usr/bin/python

import requests

api_key = "API-KEY-HERE"

try:
    data = requests.get("https://content.guardianapis.com/search?api-key="+api_key).json()
	
    sectionName = data['response']['results'][0]["sectionName"]
    webTitle = data['response']['results'][0]["webTitle"]

    print(sectionName+': '+webTitle)
	
except requests.exceptions.RequestException as e:
    print ('Something went wrong!')
