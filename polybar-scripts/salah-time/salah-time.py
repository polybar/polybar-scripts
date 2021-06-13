#!/bin/python
"""Salah time module for polybar."""
from datetime import datetime
import requests
import pickle


# Enter your country and city name
country = "Bangladesh"
city = "Dhaka"

# Username of pc
user = "robin"


def calculateTime(salahN, salahTimeH, salahTimeM):
    """Print salah name and remaining time."""
    if currentM > salahTimeM:
        salahTimeH -= 1
    remainingH = salahTimeH - currentH
    remainingM = (
        (salahTimeM - currentM)
        if salahTimeM >= currentM
        else ((salahTimeM + 60) - currentM)
    )
    if int(remainingH) >= 0 and remainingM >= 0:
        if remainingH < 10:
            remainingH = "0" + str(remainingH)
        if remainingM < 10:
            remainingM = "0" + str(remainingM)
        print("{} {}:{}".format(salahN, remainingH, remainingM))
    else:
        print("{} time".format(salahN))


todayDate = datetime.today().strftime("%d/%m/%y").split("/")[0]
currentH = int(datetime.now().strftime("%H:%M:%S").split(":")[0])
currentM = int(datetime.now().strftime("%H:%M:%S").split(":")[1])
file = open(f"/home/{user}/polybar-scripts/salah-time/checkDate.py", "rb")
data1 = pickle.load(file)
file.close()
if todayDate != data1["date"]:
    try:
        REQ = requests.get(
            f"http://api.aladhan.com/v1/timingsByCity?city={city}&country={country}&method=1"
        )
        if REQ.status_code == 200:
            fullData = REQ.json()
            data = {
                "date": todayDate,
                "FajrH": int(fullData["data"]["timings"]["Fajr"].split(":")[0]),
                "FajrM": int(fullData["data"]["timings"]["Fajr"].split(":")[1]),
                "DhuhrH": int(fullData["data"]["timings"]["Dhuhr"].split(":")[0]),
                "DhuhrM": int(fullData["data"]["timings"]["Dhuhr"].split(":")[1]),
                "AsrH": int(fullData["data"]["timings"]["Asr"].split(":")[0]),
                "AsrM": int(fullData["data"]["timings"]["Asr"].split(":")[1]),
                "MaghribH": int(fullData["data"]["timings"]["Maghrib"].split(":")[0]),
                "MaghribM": int(fullData["data"]["timings"]["Maghrib"].split(":")[1]),
                "IshaH": int(fullData["data"]["timings"]["Isha"].split(":")[0]),
                "IshaM": int(fullData["data"]["timings"]["Isha"].split(":")[1]),
                "month": int(fullData["data"]["date"]["hijri"]["month"]["number"]),
            }
            file = open(f"/home/{user}/polybar-scripts/salah-time/checkDate.py", "wb")
            pickle.dump(data, file)
            file.close()
        else:
            print("Error: BAD HTTP STATUS CODE")
    except (ValueError, IOError):
        print("Error: unable to print data")
file = open(f"/home/{user}/polybar-scripts/salah-time/checkDate.py", "rb")
data2 = pickle.load(file)
file.close()
if currentH <= data2["FajrH"]:
    calculateTime("Fajr", data2["FajrH"], data2["FajrM"])
elif currentH <= data2["DhuhrH"]:
    calculateTime("Dhuhr", data2["DhuhrH"], data2["DhuhrM"])
elif currentH <= data2["AsrH"]:
    calculateTime("Asr", data2["AsrH"], data2["AsrM"])
elif currentH <= data2["MaghribH"]:
    calculateTime("Maghrib", data2["MaghribH"], data2["MaghribM"])
elif currentH <= data2["IshaH"]:
    calculateTime("Isha", data2["IshaH"], data2["IshaM"])
else:
    data2["FajrH"] += 24
    calculateTime("Fajr", data2["FajrH"], data2["FajrM"])
