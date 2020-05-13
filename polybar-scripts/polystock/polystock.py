#!/usr/bin/env python3
from yahoo_fin import stock_info as si
import argparse

# How many decimal place to show in stock price.
roundNumber = 1

def biggestloser():
    day_losers = si.get_day_losers()
    output = str(day_losers.at[0, 'Symbol']) + ': ' + str(round(si.get_live_price(day_losers.at[0, 'Symbol']), roundNumber))
    return output

def biggestgainer():
    day_gainer = si.get_day_gainers()
    output = str(day_gainer.at[0, 'Symbol']) + ': ' + str(round(si.get_live_price(day_gainer.at[0, 'Symbol']), roundNumber))
    return output

def mostactive():
    day_active = si.get_day_most_active()
    output = str(day_active.at[0, 'Symbol']) + ': ' + str(round(si.get_live_price(day_active.at[0, 'Symbol']), roundNumber))
    return output

def customticker(ticker):
    tickerPrice = si.get_live_price(ticker)
    output = ticker + ': ' + str(round(tickerPrice, roundNumber))
    return output

def topcrypto():
    top_crypto = si.get_top_crypto()
    output = str(top_crypto.at[0, 'Symbol']) + ': ' + str(round(si.get_live_price(top_crypto.at[0, 'Symbol']), roundNumber))
    return output

def main():
    parser = argparse.ArgumentParser(description='Displays stock prices outputted in a simplified form for polybar.', epilog='Output will always be in the format of: Biggest Loser, Biggest Gainer, Most Active, Top Crypto, Custom Ticker')

    # add arguments to be called
    parser.add_argument('--biggestloser', help='Prints the stock with the biggest drop in a given day.', action='store_true')
    parser.add_argument('--biggestgainer', help='Prints the stock with the biggest gain in a given day.', action='store_true')
    parser.add_argument('--mostactive', help='Prints the most active stock in a given day.', action='store_true')
    parser.add_argument('--topcrypto', help='Prints the top cryptocurrency by market cap in a given day.', action='store_true')
    parser.add_argument('--customticker', help='Display the price of a custom ticker.', type=str)

    args = parser.parse_args()

    stocks = ""

    # parse arguments
    if args.biggestloser:
        stocks += " " + biggestloser() + " "
    if args.biggestgainer:
        stocks += " " + biggestgainer() + " "
    if args.mostactive:
        stocks += " " + mostactive() + " "
    if args.topcrypto:
        stocks += " " + topcrypto() + " "
    if args.customticker:
        stocks += " " + customticker(args.customticker) + " "

    if stocks == "":
        print("You must choose a stock to be displayed! Use --help for more details...")
    else:
        print(stocks)

main()
