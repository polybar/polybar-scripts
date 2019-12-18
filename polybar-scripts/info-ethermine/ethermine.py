#!/usr/bin/env python3

import requests


miner = "857fa14a9c7de4436ca08002a4284d5f38b22476"

data = requests.get(f"https://api.ethermine.org/miner/{miner}/dashboard").json()['data']['statistics']
data = data[-1]
current_hash_rate = data["currentHashrate"]
currentMHs = round(current_hash_rate/1e6, 1) 
print(f"{currentMHs}MH/s")
