# Script: ethermine.py

Reports the current hashrate (in MH/s) for your ethermine account

## Dependencies
Python3 and the python3 requests library are the only dependncies

## Configuration
Change the miner string in ethermine.py to your own ethereum mining address

## Module
[module/ethermine]
type = custom/script
exec = ~/polybar-scripts/ethermine.sh
interval = 60

