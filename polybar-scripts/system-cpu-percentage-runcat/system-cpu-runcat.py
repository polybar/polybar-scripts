#!/usr/bin/python3
import json
import datetime
import psutil
import os
import subprocess

# Icons for the animation
sleep = ""
icons_base = ["","","","",""]

# Path to the script
__location__ = os.path.realpath(
    os.path.join(os.getcwd(), os.path.dirname(__file__)))

# Run the script for getting the CPU usage
subprocess.Popen([os.path.join(__location__, "speedcpu.py")], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)


with open(os.path.join(__location__, "data.json"),'r+') as file:
    
    data = json.load(file)

    cpu_usage = data["SpeedClock"]
    fotograma = data["Photogram"]


    if cpu_usage<10:
        print(sleep + "  " + str(round(cpu_usage)) + "%")
    
    #If you want to change the speed of the animation, you can change the numbers below
    else:
        # You can change the interval of the different speeds.
        if cpu_usage>=10 and cpu_usage<40:
            keys = [0,0,0,0, 1,1,1,1, 2,2,2,2, 3,3,3,3, 4,4,4,4]
        elif cpu_usage>=40 and cpu_usage<70:
            keys = [0,0, 1,1, 2,2, 3,3, 4,4]
        elif cpu_usage>=70 and cpu_usage<100:
            keys = [0, 1, 2, 3, 4]

        print(icons_base[keys[fotograma%len(keys)]] + "  " + str(round(cpu_usage)) + "%")
        
        data["Photogram"] = (fotograma + 1)%5

    file.seek(0)
    json.dump(data, file, indent=4)
    file.truncate()
