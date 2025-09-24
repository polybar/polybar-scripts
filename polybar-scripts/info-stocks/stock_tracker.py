#!/bin/sh python3

"""
Script to display in Polybar-friendly way information of given stocks. Useful to see yout positions crash in live.

Usage: stock_tracker.py --tickers <ticker1> <ticker2> ..

Created by: Jesús Blázquez
Inspired in: Polystock by Zachary Ashen. His is great I just don't like yahoo_fin
"""

import argparse
import yfinance as yf

def printTicker(ticker: str):
    stock = yf.Ticker(ticker)
    data = stock.history(period="2d", interval="1d")
    prev_close, close = data["Close"].iloc[-2], data["Close"].iloc[-1]
    # price = stock.info["regularMarketPrice"]
    percent = ((close - prev_close) / prev_close) * 100
    # Colors go in the print. An example:
    # %{{F#9ece6a}} {ticker}: {percent:.2f}% %{{F-}}
    # %{{F#F7768E}} {ticker}: {percent:.2f}% %{{F-}}
    # %{{F#7dcfff}} {ticker}: {percent:.2f}% %{{F-}}
    if percent > 0:
        print(f"#1 {ticker}: {percent:.2f}%", end="")
    elif percent < 0:
        print(f"#2 {ticker}: {percent:.2f}%", end=" ")
    else:
        print(f"#3 {ticker}: {percent:.2f}%", end=" ")


parser = argparse.ArgumentParser()
parser.add_argument("--tickers", help="Tickers to display", type=str, nargs="+")
args = parser.parse_args()

if args.tickers is None:
    print("No tickers provided")
    exit(1)

tickers = args.tickers

for ticker in tickers:
    try:
        printTicker(ticker)
    except Exception as e:
        # %{{F#7dcfff}}%{{F-}}
        print(f"#4")
        exit(1)
