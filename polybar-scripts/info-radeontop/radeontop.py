#!/usr/bin/env python3
import subprocess
from subprocess import PIPE, DEVNULL
import re

"""
Example radeontop output:
1661693993.532512: bus 2d, gpu 0.83%, ee 0.00%, vgt 0.00%, ta 0.83%, sx 0.83%, sh 0.00%, spi 0.83%, sc 0.83%, pa 0.00%,
db 0.83%, cb 0.83%, vram 6.61% 539.47mb, gtt 0.92% 73.34mb, mclk 100.00% 2.000ghz, sclk 74.64% 1.168ghz
"""


class radeontop:
    def __init__(self):
        Komi = subprocess.Popen(["radeontop", "-l", "1", "-d", "-"], stdout=PIPE, stderr=DEVNULL)
        output = Komi.communicate()[0].decode('utf-8')  # Komi can communicate?
        output = output.split("\n")[1]
        self.output = output.split(",")

    def join_tuple_string(self, strings_tuple) -> str:
        return ' '.join(strings_tuple).strip()

    def get_usage(self, field):
        for x in self.output:
            if field in x:
                results = re.findall(r'(\d+.\d+)(mb|ghz)?', x)
                return list(map(self.join_tuple_string, results))

    def get_multiple_usages(self, fields: []):
        result = {}
        for x in fields:
            result[x] = self.get_usage(x)

        return result


if __name__ == "__main__":
    rtop = radeontop()
    radeontop_fields = ["gpu"]
    result = rtop.get_multiple_usages(radeontop_fields)
    format_string = f"GPU: {result['gpu'][0]}%"
    print(format_string)

