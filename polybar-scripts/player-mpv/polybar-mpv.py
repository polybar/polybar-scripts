#!/usr/bin/env python

import socket
import json
import time
import sys
import argparse
from threading import Thread

def get_property_cmd(property, request_id):
  return f'{{ "command": ["get_property", "{property}"], "request_id": {request_id} }}\n'.encode('utf-8')

MPV_SOCKET = '/tmp/mpvsocket'
BUFSIZE = 1024
METADATA_CMD = get_property_cmd('filtered-metadata', 1)
OBSERVE_METADATA_CMD = b'{ "command": ["observe_property", 1, "filtered-metadata"] }\n'
MEDIA_TITLE_CMD = get_property_cmd('media-title', 2)
PERCENT_POS_CMD = get_property_cmd('percent-pos', 3)

parser = argparse.ArgumentParser()
parser.add_argument('-t', '--truncate', metavar='N', type=int, help='truncate output to N characters')
parser.add_argument('-c', '--color', default='#fff', metavar='C', help='set color of underline (progress bar)')
args = parser.parse_args()

def first_value(data, keys):
  for key in keys:
    value = data.get(key)
    if value:
      return value

def maybe_truncate(text):
  limit = args.truncate
  return (text[:limit - 1] + '…') if limit and len(text) > limit else text

def puts(output='', pos=0):
  if pos > 0:
    output = f'%{{u{args.color}}}%{{+u}}{output[0:pos]}%{{-u}}{output[pos:len(output)]}'
  sys.stdout.write(output + '\n')
  sys.stdout.flush()

def create_client():
  client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
  while True:
    try:
      client.connect(MPV_SOCKET)
      client.send(METADATA_CMD)
      client.send(OBSERVE_METADATA_CMD)
      Thread(target=percent_pos_sender, args=[client]).start()
      break
    except (FileNotFoundError, ConnectionRefusedError):
      time.sleep(1)
  return client

def parse_msg(msg):
  messages = msg.decode('utf-8').split('\n')
  not_empty = filter(lambda s: s, messages)
  parsed = map(lambda m: json.loads(m), not_empty)
  return list(parsed)

def format_data(data):
  artist = first_value(data, ['Artist', 'Album_Artist']) or ''
  title = first_value(data, ['Title', 'icy-title']) or ''
  not_empty = filter(lambda d: d, [artist.strip(), title.strip()])
  return ' - '.join(not_empty)

def percent_pos_sender(client):
  try:
    while True:
      time.sleep(1)
      client.send(PERCENT_POS_CMD)
  except BrokenPipeError:
    pass

client = create_client()
current_output = ''
current_pos = 0
while True:
  msg = client.recv(BUFSIZE)

  # If connection is broken
  if len(msg) == 0:
    current_output = ''
    current_pos = 0
    puts()
    time.sleep(1)
    client = create_client()
    continue

  for m in parse_msg(msg):
    data = m.get('data')

    if m.get('event') == 'seek':
      client.send(PERCENT_POS_CMD)

    # 'filtered-metadata' event or response
    elif (m.get('id') == 1 or m.get('request_id') == 1) and isinstance(data, dict):
      text = format_data(data)
      if text:
        output = maybe_truncate(text)
        if output != current_output:
          current_output = output
          puts(output)
          client.send(PERCENT_POS_CMD)
      else:
        client.send(MEDIA_TITLE_CMD)

    # 'media-title' response
    elif m.get('request_id') == 2:
      current_output = maybe_truncate(data)
      puts(current_output)
      client.send(PERCENT_POS_CMD)

    # 'percent-pos' response
    elif m.get('request_id') == 3 and isinstance(data, float):
      length = len(current_output)
      pos = round(length / 100 * data)
      if pos != current_pos:
        current_pos = pos
        puts(current_output, pos)
