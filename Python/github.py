#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: Class 15.py
# Created: Wednesday, 22nd July 2020 9:15:37 pm
# Author: Rakibul Yeasin (ryeasin03@gmail.com)
# -----
# Last Modified: Wednesday, 22nd July 2020 10:53:43 pm
# Modified By: Rakibul Yeasin (ryeasin03@gmail.com)
# -----
# Copyright (c) 2020 Slishee
###


"""
This scipt automatically creates a repo
in Githuব.com using the given name
and initiazes a same git in current location
with the upstream github url
"""

import os
import sys
import json
import requests as rq
from os import system

def main(repo_name):
    username = "YOUR GITHUB USERNAME"
    token = "YOUR GITHUB TOKEN"

    create_repo = "https://api.github.com/user/repos"

    headers = {
        "Accept": "application/vnd.github.v3+json"
    }

    body = {
        "name": repo_name,
        "private": "false"
    }

    res = rq.post(create_repo, data=json.dumps(body), headers=headers, auth=(username, token))
    ssh_uri = json.loads(res.text)["ssh_url"]
    print(ssh_uri)

    os.mkdir(repo_name)
    os.chdir(repo_name)

    os.system(f'''
        git init &&
        git remote add origin {ssh_uri}
    ''')

if __name__ == "__main__":
    if len(sys.argv) > 1:
        repo_name = sys.argv[1]
        main(repo_name)
    else:
        print("[+] Please provide REPO name!")
