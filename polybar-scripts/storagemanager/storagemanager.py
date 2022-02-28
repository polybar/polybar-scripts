#!/usr/bin/env python3
import subprocess
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-f', required=True, dest='format')
parser.add_argument('-d', required=True, dest='disk')
args = parser.parse_args()

storageused = subprocess.check_output("df -H " + args.disk + " | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $3 }'", shell=True).decode().replace("\n", "")
storageavail = subprocess.check_output("df -H " + args.disk + " | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $4 }'", shell=True).decode().replace("\n", "")
storagesize = subprocess.check_output("df -H " + args.disk + " | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $2 }'", shell=True).decode().replace("\n", "")
storageleft = subprocess.check_output("df -Hi " + args.disk + " | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $4 }'", shell=True).decode().replace("\n", "")
print(args.format.replace("{used}", storageused).replace("{avail}", storageavail).replace("{left}", storageleft).replace("{size}", storagesize))
