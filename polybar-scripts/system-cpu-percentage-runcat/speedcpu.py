#!/usr/bin/python3

import os
import psutil
import datetime
import json

__location__ = os.path.realpath(
    os.path.join(os.getcwd(), os.path.dirname(__file__)))

with open(os.path.join(__location__, "data.json"),'r+') as file:
    data = json.load(file)

    if int(datetime.datetime.now().strftime("%S"))%10==0:
        cpu_usage = psutil.cpu_percent(2)
        data["SpeedClock"] = round(cpu_usage,1)
    
    else:
        cpu_usage = data["SpeedClock"]
    
    file.seek(0)
    json.dump(data, file, indent=4)
    file.truncate()