#!/usr/bin/env python3
# -*- coding: utf-8 -*- # PEP 263

from huawei_lte_api.Client import Client
from huawei_lte_api.Connection import Connection

# Configuration
host = '192.168.8.1'
username = 'admin'
password = ''

MODEM_URL = f"http://{username}:{password}@{host}/"


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
    with Connection(MODEM_URL) as connection:
        # This just simplifies access to separate API groups,
        # you can use device = Device(connection) if you want
        client = Client(connection)

        signal = client.device.signal()
        traffic = client.monitoring.traffic_statistics()
        sms = client.sms.sms_count()
        status = client.monitoring.status()
        sms_unread = int(sms['LocalUnread'])

        power = status['SignalIcon']
        sinr = signal['sinr']
        sms_icon = '' if sms_unread else ''
        down = scale_units(int(traffic['CurrentDownloadRate']) * 8)
        up = scale_units(int(traffic['CurrentUploadRate']) * 8)
        result = f":{power} SINR:{sinr} {sms_icon}:{sms_unread} {down} {up}"

        print(result)
