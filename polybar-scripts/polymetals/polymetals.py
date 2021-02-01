#!/usr/bin/env python3
#Small program to display precious metal future prices on polybar. Written by Zeb.


#Import stuff and set roundBy number to keep decimals in check.
from yahoo_fin import stock_info as si
import argparse
roundBy = 1


#Define PM types and get price from yahoo.
def silver():
    price = si.get_live_price("SI=F")
    output = str(round(price, roundBy))
    return output

def gold():
    price = si.get_live_price("GC=F")
    output = str(round(price, roundBy))
    return output

def platinum():
    price = si.get_live_price("PL=F")
    output = str(round(price, roundBy))
    return output

def displayArgs():
    #Args to display
    parser = argparse.ArgumentParser()
    parser.add_argument( "-s", '--silver', help='display the price of silver.', action="store_true")
    parser.add_argument("-g", '--gold', help='display the price of gold.', action="store_true")
    parser.add_argument("-p", '--platinum', help='display the price of platinum.', action="store_true")
    args = parser.parse_args()
    metal = ""
    
    #Parse the args
    if args.silver:
        metal += "Ag: $" + silver() + "/oz | "
    if args.gold:
        metal += "Au: $" + gold() + "/oz | "
    if args.platinum:
        metal += "Pt: $" + platinum() + "/oz | "

    #Display the args (if they exist)
    if metal == "":
        print("No metal chosen to display!")
    else:
        print(metal)

if __name__ == '__main__':
    displayArgs()
