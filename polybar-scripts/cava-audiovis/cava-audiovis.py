#!/bin/env python3
import argparse
import os
import signal
import subprocess
import sys
import tempfile

if len(sys.argv) > 1 and sys.argv[1] == '--subproc':
    ramp_list = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
    ramp_list.extend(
        f'%{{F#{color.strip(" #")}}}█%{{F-}}'
        for color in sys.argv[2].split(',')
        if color
    )
    while True:
        cava_input = input().strip().split()
        cava_input = [int(i) for i in cava_input]
        output = ''
        for bar in cava_input:
            if bar < len(ramp_list):
                output += ramp_list[bar]

            else:
                output += ramp_list[-1]

        print(output)

parser = argparse.ArgumentParser()
parser.add_argument('-f', '--framerate', type=int, default=60,
                    help='Framerate to be used by cava, default is 60')
parser.add_argument('-b', '--bars', type=int, default=8,
                    help='Amount of bars, default is 8')
parser.add_argument('-e', '--extra_colors', default='fdd,fcc,fbb,faa',
                    help='Color gradient used on higher values, separated by commas, default is')
parser.add_argument('-c', '--channels', choices=['stereo', 'left', 'right', 'average'],
                    help='Audio channels to be used, defaults to stereo')

opts = parser.parse_args()
conf_channels = ''
if opts.channels != 'stereo':
    conf_channels = (
        'channels=mono\n'
       f'mono_option={opts.channels}'
    )

conf_ascii_max_range = 12 + len([i for i in opts.extra_colors.split(',') if i])

cava_conf = tempfile.mkstemp('','polybar-cava-conf.')[1]
with open(cava_conf, 'w') as cava_conf_file:
    cava_conf_file.write(
        '[general]\n'
       f'framerate={opts.framerate}\n'
       f'bars={opts.bars}\n'
        '[output]\n'
        'method=raw\n'
        'data_format=ascii\n'
       f'ascii_max_range={conf_ascii_max_range}\n'
        'bar_delimiter=32'
        + conf_channels
    )

cava_proc = subprocess.Popen(['cava', '-p', cava_conf], stdout=subprocess.PIPE)
self_proc = subprocess.Popen(['python3', __file__, '--subproc', opts.extra_colors], stdin=cava_proc.stdout)

def cleanup(sig, frame):
    os.remove(cava_conf)
    cava_proc.kill()
    self_proc.kill()
    sys.exit(0)

signal.signal(signal.SIGTERM, cleanup)
signal.signal(signal.SIGINT,  cleanup)

self_proc.wait()
