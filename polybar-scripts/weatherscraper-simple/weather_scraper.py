#!/usr/bin/env python3

from bs4 import BeautifulSoup
import requests
import re
import json
from datetime import datetime, timedelta
import argparse
import os



def main():
    
    # define argparse
    parser = argparse.ArgumentParser(
        formatter_class = argparse.ArgumentDefaultsHelpFormatter,
        description     = "scraps weather.com for weather data"
    )
    
    parser.add_argument("location_code", type=str,                         help="specifies the location for where to check the weather")
    parser.add_argument("-n", "--n",     type=valid_n,    default=2,       help="specify how many forecasts should be scraped") 
    parser.add_argument("-u", "--unit",  type=valid_unit, default='C',     help="sets the unit, valid units: C, F, H")
    parser.add_argument("-l", "--lang",  type=valid_lang, default='en-GB', help="sets the language, format: <language code>-<country code>")
    parser.add_argument("-d", "--dir",   type=valid_dir,                   help="specify the directory for the output.json file")

    args = parser.parse_args()

    # Check if everything is valid
    if args.location_code and args.n and args.unit and args.lang: 

        json = scrap_it(args.location_code, args.n, args.unit, args.lang)
        
        # Export via file or stdout
        if args.dir:
            with open(args.dir+'/output.json', "w") as f:
                   f.write(json + '\n')
        else:
            print(json)
    
        
  
# check if url is valid via regex
def valid_url(value):
    if not re.search('^https://weather.com/\S+/weather/hourbyhour/l/\S+$', value):
        raise argparse.ArgumentTypeError(f"'{value}' is not a valid url")
    return value



# Check if max is a signed int
def valid_n(value):
    try:
        n = int(value)
        if n < 1: 
            raise argparse.ArgumentTypeError(f"'{value}' is not greater 0")
        return n
    except ValueError:
        raise argparse.ArgumentTypeError(f"'{value}' is not an int")



# Check if unit is valid
def valid_unit(value):
    match value:
        case 'C' | 'Celsius':
            return 'm'
    
        case 'F' | 'Fahrenheit':
            return 'e'
        
        case 'H' | 'Hybrid':
            return 'h'

        case _:
            raise argparse.ArgumentTypeError(f"'{value}' is not a valid unit. Valid units: C, F, H")



# Check if lang is valid
def valid_lang(value):
    if not re.match('^([a-z]{2})-([A-z]{2})$', value):
        raise argparse.ArgumentTypeError(f"'{value}' is not a valid language setting, format: <languadge code>-<country code>")
    return value



# Check if dir exists
def valid_dir(value):
    if not os.path.isdir(value):
        raise argparse.ArgumentTypeError(f"'{value}' is not a valid dir")
    return value
    


# Gets weather.com URL and returns a json object containing the weather data.
def scrap_it(location_code, n, unit, lang):
    
    url_hourly = 'https://weather.com/' + lang + '/weather/hourbyhour/l/' + location_code + '?unit=' + unit 
    url_days   = 'https://weather.com/' + lang + '/weather/tenday/l/'     + location_code + '?unit=' + unit 
    

    # Setting up scraper
    page_hourly = BeautifulSoup(requests.get(url_hourly).text, 'lxml')
    page_days   = BeautifulSoup(requests.get(url_days  ).text, 'lxml')

    # Getting the location
    location = page_hourly.find('span', class_ = 'LocationPageTitle--PresentationName--1QYny')\
        .text.strip().split(', ')

    # Init the dict
    data = {}
    data['request']  = {}
    data['request']['timestamp']    = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    data['request']['urls']         = [url_hourly, url_days]
    data['request']['last_updated'] = {}
    
    data['location'] = {}
    data['location']['city']        = location[0]
    
    # if location has only city and country eg.: Vienna
    if len(location) == 2:
        data['location']['state']   = location[0]
    else:
        data['location']['state']   = location[1]
    data['location']['country']     = location[len(location)-1]
    

    # Find out the current date 
    ugly_date = page_hourly.find( 'h2', id = re.compile('currentDateId0$') )
    ugly_date = str(ugly_date.text) + ' ' + str(datetime.now().year)
    hourly_date = datetime.strptime(ugly_date, '%A, %d %B %Y')
    
    # Get locale timestamp and add it to dict
    ugly_time = page_hourly.find('div', class_ = 'HourlyForecast--timestamp--MVnBF')\
        .text.strip('As of ').split(' ')[0].split(':')

    locale_date = hourly_date.replace(hour=int(ugly_time[0]), minute=int(ugly_time[1]))
    
    data['location']['locale_timestamp'] = locale_date.strftime("%Y-%m-%d %H:%M:%S")


    # Calc the last_updated time in the users timezone (will be wrong if the last_updated time is bigger 15min.)
    now = datetime.now().replace(second=0, microsecond=0)   

    if now > locale_date:
        diff = now - locale_date
        diff_min = int(diff.total_seconds()/60)
        last_updated = locale_date + timedelta(minutes=( int(diff_min/15) * 15) )

    elif now < locale_date:
        diff = locale_date - now     
        diff_min = int(diff.total_seconds()/60)
        last_updated = locale_date - timedelta(minutes= diff_min + (15-diff_min%15))

    else:
        last_updated = now
    
    data['request']['last_updated'] = last_updated.strftime("%Y-%m-%d %H:%M:%S")

    data['location']['forecasts'] = {}
    data['location']['forecasts']['dates'] = []
       
       
    
    # list of the weather stats per hour for a date
    list_weather_dict = []
    
    # list of dicts of dates and the list_weather_dict
    list_dates = []
    
    # list of date stats combined with the weather and day_night stats
    list_dates_dict = []
    
    # Iterate over n forecasts and create the weather_dict and add to list_dates
    for index in range(0, n):
        
        # Check if its a new date section
        # if yes: Clear weather_dict
        ugly_date = page_hourly.find( 'h2', id = re.compile('currentDateId' + str(index) + '$') )
        if ugly_date != None:
            list_weather_dict = []


        # Check if its a new weather section
        weather = page_hourly.find( id = re.compile('detailIndex' + str(index) + '$') )
        if weather != None:
            
            # Create the dict and the order
            weather_stats_dict = {
                'time'        : '',
                'temperature' : '',
                'feels like'  : '',
                'info'        : "",
                'rain chance' : '',
                'rain amount' : '',
                'humidity'    : '',
                'wind'        : '',
                'cloud cover' : '',
                'uv index'    : ''
            }

            # Get the time
            time = weather.find('h3',   attrs={ "data-testid" : "daypartName" })
            weather_stats_dict['time'] = time.text
            
            # Get the temperature
            temp = weather.find('span', attrs={ "data-testid" : "TemperatureValue" })
            weather_stats_dict['temperature'] = temp.text
            
            # Get icon info -> is cloudy, foggy,mostly sunny, stormy, ...    
            info = weather.find( attrs={ "data-testid" : "Icon" })
            weather_stats_dict['info'] = info.text


            # Get rain chance
            rain_chance = weather.find('span', attrs={ "data-testid" : "PercentageValue" })
            weather_stats_dict['rain chance'] = rain_chance.text

            # Iterate over detailed weather stats
            lu = weather.find( class_ = 'DaypartDetails--Content--hJ52O DaypartDetails--contentGrid--1SWty').ul
            for li in lu:
                # Get label and values
                label = str(li.div.find_all('span')[0].text).lower()
                value = li.div.find_all('span')[1].text
                
                weather_stats_dict[label] = value 
            # Add all weather_stats to the list of weather dict
            list_weather_dict += [weather_stats_dict]
                  
        
        # Check if its a new date section and build the final date dict
        if ugly_date != None:
            
            # Format the next date
            ugly_date = str(ugly_date.text) + ' ' + str(datetime.now().year)
            hourly_date = datetime.strptime(ugly_date, '%A, %d %B %Y')
            list_dates += [ {hourly_date:list_weather_dict} ]
   

    
    # Create the date_dict ( day/night stats of each date, weather of the date and the date)
    # and add it to the list_dates_dict
    
    # Iterate over all dates
    yesterday_night_dict = None
    for index, date_dict in enumerate(list_dates):
        # Get the weather dicts of the date
        for date in date_dict:
            
            # If yesterday_night dict is set, the index has to be increased by 1 to skip the yesterday stats 
            if yesterday_night_dict != None:
                index += 1

            day_night = page_days.find( id = re.compile('detailIndex' + str(index) + '$') )
            if day_night != None:

                # Get day_night date
                ugly_date = day_night.find('span', class_ = 'DailyContent--daypartDate--2A3Wi')
                if ugly_date != None:
                    
                    # Format the date and add it to dict
                    ugly_date_day = int(str(ugly_date.text).split(' ')[1])
                    
                    # if only today is yesterday night eg.: 01:00
                    its_yesterday_night = False
                    if ugly_date_day == date.day-1:
                        its_yesterday_night = True
                        
                        # set date yesterday 
                        yesterday = date - timedelta(days=1)
                        
                        # Get night stats for yesterday_night
                        day_night_avg = day_night.find_all(class_ = 'DailyContent--dataPoints--1Nya6')
                        
                        # only night stats present
                        night_dict = { 'avg. weather': {
                            'temperature' : '',
                            'info'        : '',
                            'rain chance' : '',
                            'humidity'    : '',
                            'wind'        : '',
                            'uv index'    : ''
                        } }

                        temps = day_night.find_all('span', attrs={ "data-testid" : "TemperatureValue" })
                        
                        highest_temp = temps[0].text
                        lowest_temp = temps[1].text
                        if highest_temp == '--': highest_temp = lowest_temp
                        night_dict['avg. weather']['temperature'] = temps[2].text
                        
                        # Get icon info -> is cloudy, foggy,mostly sunny, stormy, ...    
                        infos = day_night.find_all( attrs={ "data-testid" : "weatherIcon" })
                        night_dict['avg. weather']['info'] = infos[0].text
                        
                        # Get rain_chance
                        rain_chances = day_night.find_all( attrs={ "data-testid" : "PercentageValue" })
                        night_dict['avg. weather']['rain chance'] = rain_chances[0].text

                        # Get wind
                        winds = day_night.find_all( attrs={ "data-testid" : "Wind" })
                        night_dict['avg. weather']['wind'] = winds[0].text


                        lu = day_night.find(class_ = "DaypartDetails--DetailsTable--2VLwj DaypartDetails--col1--3kk-U DetailsTable--twoColumn--3ybwq").ul
                        for li in lu:
                            label = str(li.div.find_all('span')[0].text).lower()
                            value = li.div.find_all('span')[1].text
                            
                            # moon stats should not be in avg weather
                            if label.startswith('moon'):
                                night_dict[label] = value
                            else:
                                night_dict['avg. weather'][label] = value


                        moonphase = day_night.find('span', attrs={ "data-testid" : "moonPhase" })
                        night_dict['moonphase'] = moonphase.text
                    

                        # Create yesterday_night dict
                        yesterday_night_dict = {
                            'date'                : yesterday.strftime('%Y-%m-%d'),
                            'lowest temperature'  : lowest_temp,
                            'highest temperature' : highest_temp,
                            'night'               : night_dict
                        }
                        
                        # Get the next date -> actually today
                        day_night = page_days.find( id = re.compile('detailIndex' + str(index + 1) + '$') )
                        if day_night != None:

                            ugly_date = day_night.find('span', class_ = 'DailyContent--daypartDate--2A3Wi')
                            if ugly_date != None:
                                ugly_date_day = int(str(ugly_date.text).split(' ')[1])

                    

                    # its today
                    if ugly_date_day == date.day:
                        
                        # Add avg. rain chance and avg. wind    
                        day_night_avg = day_night.find_all(class_ = 'DailyContent--dataPoints--1Nya6')
                        
                        day_dict   = { 'avg. weather': {
                            'temperature' : '',
                            'info'        : '',
                            'rain chance' : '',
                            'humidity'    : '',
                            'wind'        : '',
                            'uv index'    : ''
                        } }
                        night_dict = { 'avg. weather': {
                            'temperature' : '',
                            'info'        : '',
                            'rain chance' : '',
                            'humidity'    : '',
                            'wind'        : '',
                            'uv index'    : ''
                        } }

                        # only night stats present
                        if len(day_night_avg) == 1:
                            
                            # Get the temperatures
                            temps = day_night.find_all('span', attrs={ "data-testid" : "TemperatureValue" })
                            
                            highest_temp = temps[0].text
                            lowest_temp = temps[1].text
                            night_dict['avg. weather']['temperature'] = temps[2].text
                            
                            # Get icon info -> is cloudy, foggy,mostly sunny, stormy, ...    
                            infos = day_night.find_all( attrs={ "data-testid" : "weatherIcon" })
                            night_dict['avg. weather']['info'] = infos[0].text
                            
                            # Get rain_chance
                            rain_chances = day_night.find_all( attrs={ "data-testid" : "PercentageValue" })
                            night_dict['avg. weather']['rain chance'] = rain_chances[0].text

                            # Get wind
                            winds = day_night.find_all( attrs={ "data-testid" : "Wind" })
                            night_dict['avg. weather']['wind'] = winds[0].text


                            lu = day_night.find(class_ = "DaypartDetails--DetailsTable--2VLwj DaypartDetails--col1--3kk-U DetailsTable--twoColumn--3ybwq").ul
                            for li in lu:
                                label = str(li.div.find_all('span')[0].text).lower()
                                value = li.div.find_all('span')[1].text
                                
                                # moon stats should not be in avg weather
                                if label.startswith('moon'):
                                    night_dict[label] = value
                                else:
                                    night_dict['avg. weather'][label] = value


                        # day/night stats present
                        elif len(day_night_avg) == 2:

                            # Get the temperatures
                            temps = day_night.find_all('span', attrs={ "data-testid" : "TemperatureValue" })
                            
                            highest_temp = temps[0].text
                            lowest_temp = temps[1].text
                            day_dict['avg. weather']['temperature'] = temps[2].text
                            night_dict['avg. weather']['temperature'] = temps[3].text
                            
                            # Get icon info -> is cloudy, foggy,mostly sunny, stormy, ...    
                            infos = day_night.find_all( attrs={ "data-testid" : "weatherIcon" })
                            day_dict['avg. weather']['info'] = infos[0].text
                            night_dict['avg. weather']['info'] = infos[1].text
                            
                            # Get rain_chance
                            rain_chances = day_night.find_all( attrs={ "data-testid" : "PercentageValue" })
                            day_dict['avg. weather']['rain chance'] = rain_chances[0].text
                            night_dict['avg. weather']['rain chance'] = rain_chances[1].text

                            # Get wind
                            winds = day_night.find_all( attrs={ "data-testid" : "Wind" })
                            day_dict['avg. weather']['wind'] = winds[0].text
                            night_dict['avg. weather']['wind'] = winds[1].text

                            
                            lu = day_night.find(class_ = "DaypartDetails--DetailsTable--2VLwj DaypartDetails--col1--3kk-U DetailsTable--twoColumn--3ybwq").ul
                            for li in lu:
                                label = str(li.div.find_all('span')[0].text).lower()
                                value = li.div.find_all('span')[1].text

                                # moon stats should not be in avg weather
                                if label.startswith('sun'):
                                    day_dict[label] = value
                                else:
                                    day_dict['avg. weather'][label] = value
                            

                            lu = day_night.find(class_ = "DaypartDetails--DetailsTable--2VLwj DaypartDetails--col2--2XNui DetailsTable--twoColumn--3ybwq").ul
                            for li in lu:
                                label = str(li.div.find_all('span')[0].text).lower()
                                value = li.div.find_all('span')[1].text

                                # moon stats should not be in avg weather
                                if label.startswith('moon'):
                                    night_dict[label] = value
                                else:
                                    night_dict['avg. weather'][label] = value

                        
                        moonphase = day_night.find('span', attrs={ "data-testid" : "moonPhase" })
                        night_dict['moonphase'] = moonphase.text

                    
                        # Create the dict for the current date and set the values
                        if its_yesterday_night:
                             # Create default date dicty but with the yesterday_night dict
                             list_dates_dict +=  [ {
                                'date'                : date.strftime('%Y-%m-%d'),
                                'lowest temperature'  : lowest_temp,
                                'highest temperature' : highest_temp,
                                'weather'             : date_dict[date],
                                'yesterday_night'     : yesterday_night_dict,
                                'day'                 : day_dict, 
                                'night'               : night_dict 
                            } ]
                        else:
                            list_dates_dict +=  [ {
                                'date'                : date.strftime('%Y-%m-%d'),
                                'lowest temperature'  : lowest_temp,
                                'highest temperature' : highest_temp,
                                'weather'             : date_dict[date],
                                'day'                 : day_dict, 
                                'night'               : night_dict 
                            } ]
                           

    

    # Add the list_dates_dict to the json object
    data['location']['forecasts'] = list_dates_dict


    json_data = json.dumps(data)
    return json_data

      
if __name__ == "__main__":
    main()

    
