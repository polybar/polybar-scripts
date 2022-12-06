#!/usr/bin/python3
# -*- coding: utf-8 -*- # PEP 263

import requests
from binascii import unhexlify

# Configuration
host = '192.168.8.1'
username = 'root'
password = ''

LOGIN_URL = f"http://{host}/cgi-bin/luci/"
MODEM_URL = f"http://{host}/cgi-bin/luci/?status=1"
SMS_URL = f"http://{host}/cgi-bin/luci/admin/services/modem_read_sms/all?block=0"
BW_URL = f"http://{host}/cgi-bin/luci/admin/status/realtime/bandwidth_status/wwan0"


def scale_units(rate):
    # input: integer
    decimal_places = 2
    for unit in ['bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps']:
        if rate < 1000.0:
            if unit == 'bps':
                decimal_places = 0
            break
        rate /= 1000.0
    return f"{rate:.{decimal_places}f}{unit}"


def sms_concatenate(data):
    # input: list of dicts
    sms = list()
    concat = dict()
    for item in data:
        if not item['fail']:
            if 'c_ref' in item:
                if item['c_ref'] not in concat:
                    concat[item['c_ref']] = list()
                concat[item['c_ref']].append(item)
            else:
                sms.append(item)
    if len(concat):
        for key, parts in concat.items():
            parts.sort(key=lambda x: x['c_cur'])
            for part in parts:
                if part['c_cur'] == 1:
                    sms.append(part)
                else:
                    sms[-1]['data'] += part['data']
    return sms


def sms_decode(sms):
    # input: dict
    if sms['dcs'] == 2:
        sms['data'] = unhexlify(sms['data']).decode('utf-16be')
    return sms


if __name__ == '__main__':
    # setup session and authenticate
    s = requests.Session()
    s.post(LOGIN_URL, data={'luci_username': username, 'luci_password': password})
    s.headers.update({'Content-Type': 'application/json'})

    # get lte modem stats (luci-mod-microdrive)
    r = s.get(MODEM_URL)
    r = r.json()
    name = r['ifg']['spn']
    lvl = r['ifg']['rssi_lv']
    rssi = r['ifg']['cell_lte'][0]['rssi']
    rsrp = r['ifg']['cell_lte'][0]['rsrp']
    sinr = r['ifg']['cell_lte'][0]['sinr']
    result = f"{name}  {lvl}% RSSI {rssi}dBm RSRP {rsrp}dBm SINR {sinr}dB"

    # get sms count (luci-mod-microdrive)
    r = s.get(SMS_URL)
    r = r.json()
    mem_total = 255
    mem_used = 0
    sms_count = 0
    if r['code'] == 0 and 'out' in r and 'sms' in r['out']:
        mem_total = r['out']['mem']['total']
        mem_used = r['out']['mem']['used']
        data = r['out']['sms']
        if len(data):
            sms = sms_concatenate(data)
            sms_count = len(sms)
    icon = '' if sms_count else ''
    # if mem_used > mem_total * 0.90:
    #    sms_count = 'MANY'
    result = result + f" {icon} {sms_count}"

    # get traffic stats
    # the response is array of array [[TIME, RXB, RXP, TXB, TXP]]
    # we only need two last items with TIME, RXB and TXB fields
    r = s.get(BW_URL)
    r = r.json()
    rxb = 0
    txb = 0
    if len(r) >= 2:
        # get last two items
        a = r.pop()
        b = r.pop()
        # normalize difference against time interval
        # this code from luci XHR.poll function
        time_delta = a[0] - b[0]
        rxb = scale_units((a[1] - b[1]) / time_delta * 8)
        txb = scale_units((a[3] - b[3]) / time_delta * 8)
    result = result + f" {rxb} {txb}"

    print(result)
