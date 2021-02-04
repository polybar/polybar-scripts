#!/usr/bin/python3

import requests
import nicehash 
import time
from pprint import pprint

from nh_config import *

nh_api = nicehash.private_api('https://api2.nicehash.com', nh_org_id, nh_api_key_code, nh_api_secret_key_code)

def get_btc_to_local(local_currency):
    r = requests.get('https://paxful.com/rest/v1/currencies/' + local_currency).json()
    return r['data']['rate']['btc']

btc_price = get_btc_to_local(currency)

def get_mining_info():
    r = nh_api.request('GET', '/main/api/v2/mining/rigs2', '', '')
    totalRigs = r['totalRigs']
    activeRigs = r['minerStatuses']['MINING']
    btc_profitability = r['totalProfitability']
    local_profitability = round(btc_profitability * btc_price - unmanaged_daily_electricity_cost, 2)
    return "%{u#fba342}%{+u}Rigs: " + f"{activeRigs}/{totalRigs}" + "%{O10}" + f"Profit: {local_profitability} {currency} / day" + "%{-u}"

print(get_mining_info())

