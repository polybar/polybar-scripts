#!/usr/bin/python
import sys
import datetime
import numpy as np
import pandas as pd

mindayidx = 3
dayidxs = {'Mon':3,'Tue':4,'Wed':5,'Thu':6,'Fri':7,'Sat':8,'Sun':9}
#idxday = {3:'Mon',4:'Tue',5:'Wed',6:'Thu',7:'Fri',8:'Sat',9:'Sun'}
idxday =  {v:k for k,v in dayidxs.items()}
schedule = pd.read_csv('~/schedules/schedule.csv'
                        ,delimiter=',')

def scrapedate():
    now = datetime.datetime.now()
    day =  now.strftime("%a")
    hour = now.hour
    if now.minute < 30:
        minn = 00
    else:
        minn = 30
    return day,hour,minn

def cycleday(cday,dayincrement):
    if dayincrement == 0:
        return cday
    else:
        newidx = dayidxs[cday] + dayincrement
        if newidx > 9:
            newidx = 3
        elif newidx < 3:
            newidx = 9
        return idxday[newidx]

def cyclemin(minn,modtime):
    if (modtime % 2) != 0:
        if minn == 30:
            return 0
        elif minn == 0:
            return 30
    else:
        return minn

def cyclehour(hour,modtime,minn):
    dayincrement=0
    if modtime > 0:
        if minn == 30:
            hour += ((modtime-1)/2)+1
        elif minn == 0:
            hour += ((modtime)/2)
    elif modtime < 0:
        if minn == 0:
            hour -= (1+((abs(modtime)-1)/2))
        elif minn == 30:
            hour -= abs(modtime)/2
    else:
        return hour,dayincrement
    #handle day change
    if hour >= 24:
        hour = hour - 24
        dayincrement = 1
    elif hour < 0:
        hour = 24 + hour
        dayincrement = -1
    return hour,dayincrement

def formathour(tfhour,minn):
    am='AM'
    if tfhour > 12:
        tfhour -= 12
        am='PM'
    elif tfhour == 12:
        am='PM'
    elif tfhour == 00:
        tfhour = 12
    if minn == 0:
        minn = '00'
    return '{}:{}{}'.format(tfhour,minn,am)

def getactivity(day,hour,minn):
    activity = schedule[(schedule['hour'] == hour) & (schedule['min'] == minn)][day].values[0]
    if activity == None:
        return 'None'
    else:
        return activity

def main(modtime):
    day,hour,minn = scrapedate()
    hour,incr = cyclehour(hour,modtime,minn)
    day = cycleday(day,incr)
    minn = cyclemin(minn,modtime)
    activity = getactivity(day,hour,minn)
    ftime = formathour(hour,minn)
    return '{} {}'.format(ftime,activity)


if __name__ == '__main__':
    modtime = 0
    if len(sys.argv) > 1:
        modtime = int(float(sys.argv[1]))
    print(main(modtime))
