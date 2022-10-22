# WeatherScraper
Scraps the weather.com site and displays the weather in the bar.



### weather_scraper.py
Is the same as the openweathermap scripts but can display up to 48h forecasts and has much more weather info.  
The `weather_scraper.py` scraps the weather.com site and returns the forecasts in json format for the given location.

### weather.sh
The weather.sh script uses the python script to get the next two hourly forecasts and  
and returns the string to be used by polybar.



## Example module 
```ini
[module/weather-scraper]
type              = custom/script
exec              = cd ~/polybar-scripts/polybar-scripts/weatherscraper-simple && ./weather.sh
internal          = 600

label-font        = 1
label             = %output%
format-foreground = ${colors.primary}
format-background = ${colors.background}
```

Displays on the bar:

![alt text](https://raw.githubusercontent.com/FromWau/WeatherScraper/main/polybar-weather-module.png)



## Usage of the weather_scraper.py
```bash
usage: weather_scraper.py [-h] [-n N] [-u UNIT] [-l LANG] [-d DIR] location_code

scraps weather.com for weather data

positional arguments:
  location_code         specifies the location for where to check the weather

options:
  -h, --help            show this help message and exit
  -n N, --n N           specify how many forecasts should be scraped (default: 2)
  -u UNIT, --unit UNIT  sets the unit, valid units: C, F, H (default: C)
  -l LANG, --lang LANG  sets the language, format: <language code>-<country code> (default: en-GB)
  -d DIR, --dir DIR     specify the directory for the output.json file (default: None)
```



### How to change the location/ from where to get the location_code?
Just go to https://weather.com/ and search for the desired city in the search.  
For example, searching for London will redirect you to:  
https://weather.com/weather/today/l/5d3ac36b50e4aa01e9916508005d45eab1dffb15cb59d5b38cce3ca54d24c65d

The location_code is the last part of the url, so in this case:  
5d3ac36b50e4aa01e9916508005d45eab1dffb15cb59d5b38cce3ca54d24c65d

Inside the weather.sh set the location_code for the variable LOCATION_CODE.


## Setup

Install python dependencies: 
```bash
pip install -r requirements.txt
```
Install jq:
```bash
pacman -S jq
```

