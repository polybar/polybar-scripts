#!/usr/bin/python3
# -*- coding: utf-8 -*- # PEP 263

import requests
import luci


LOGIN_URL = f"http://{luci.host}/cgi-bin/luci/"
MODEM_URL = f"http://{luci.host}/cgi-bin/luci/?status=1"
SMS_URL = f"http://{luci.host}/cgi-bin/luci/admin/services/modem_read_sms/all?block=0"
BW_URL = f"http://{luci.host}/cgi-bin/luci/admin/status/realtime/bandwidth_status/wwan0"


def scale_units(rate):
    decimal_places = 2
    for unit in ['bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps']:
        if rate < 1000.0:
            if unit == 'bps':
                decimal_places = 0
            break
        rate /= 1000.0
    return f"{rate:.{decimal_places}f}{unit}"


if __name__ == '__main__':
    # setup session and authenticate
    s = requests.Session()
    s.post(LOGIN_URL, data={'luci_username': luci.username, 'luci_password': luci.password})
    s.headers.update({'Content-Type': 'application/json'})

    # get lte modem stats (luci-mod-microdrive)
    r = s.get(MODEM_URL)
    r = r.json()
    op = r['ifg']['spn']
    lvl = r['ifg']['rssi_lv']
    rssi = r['ifg']['cell_lte'][0]['rssi']
    rsrp = r['ifg']['cell_lte'][0]['rsrp']
    sinr = r['ifg']['cell_lte'][0]['sinr']
    result = f"{op}  {lvl}% RSSI {rssi}dBm RSRP {rsrp}dBm SINR {sinr}dB"

    # get unread sms count (luci-mod-microdrive)
    r = s.get(SMS_URL)
    r = r.json()
    sms_unread = 0
    if r['code'] == 0:
        sms_count = len(r['out']['sms'])
        if sms_count > 0:
            for item in r['out']['sms']:
                if item['stat'] == 'read':
                    continue
                else:
                    sms_unread += 1
    icon = '' if sms_unread else ''
    result = result + f" {icon} {sms_unread}"

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
