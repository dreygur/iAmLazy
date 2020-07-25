#!/usr/bin/env python3

# This script pushed any script to `paste.ubuntu.com`
# and returns the paste url

# Author: Rakibul Yeasin (@dreygur)

import os
import sys
import requests as rq
from sys import platform

def push(source):
    with open(source, "r") as inp:
        text = inp.read()

    url = "https://paste.ubuntu.com/"
    header = {
        "Host": "paste.ubuntu.com",
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.5",
        "Accept-Encoding": "gzip, deflate, br",
        "Referer": "https://paste.ubuntu.com/",
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-Length": "62",
        "DNT": "1",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1"
    }

    data = {
        "poster": "Rakibul Yeasin",
        "syntax": "python3",
        "expiration": "",
        "content": text
    }

    res = rq.post(url, data=data, headers=header)
    print(res.url)

if __name__ == "__main__":
    if platform.startswith('linux'):
        bin_path = "/usr/local/bin"
        if os.path.dirname(os.path.abspath(__file__)) != bin_path:
            os.system(f"cp {__file__} {bin_path}pastebin")

    source = sys.argv[1]
    push(source)
