#!/usr/bin/env python

import os
import re
import time
import base64
import platform
import requests
import subprocess
import zipfile

uri = "http://localhost:3333/session"
header = {
  "content-type": "application/json",
}

def download_driver():
  zip_path = os.path.join(os.getcwd(), 'chromedriver.zip')
  # Get the Installed Chrome version
  if platform.system().lower() == "linux":
    data = subprocess.Popen(['google-chrome-stable', '--version'], stdout=subprocess.PIPE).communicate()[0].decode('utf-8')
    operating_sys = platform.system().lower() + platform.architecture()[0][:2]
  elif platform.system().lower() == 'windows':
    data = subprocess.Popen(["powershell", r"(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo"], shell=False, stdout=subprocess.PIPE).communicate()[0].decode('utf-8')
    operating_sys = "win32"
  
  chrome_version = re.search(r'\d+\.\d+\.\d+\.\d+', data).group(0)
  download_url = f'https://chromedriver.storage.googleapis.com/{chrome_version}/chromedriver_{operating_sys}.zip'
  while requests.get(download_url).status_code == 404:
    ver_string = chrome_version.split('.')
    ver = int(ver_string[-1])
    chrome_version = '.'.join(ver_string[:3]) + '.' + str(ver -1)
    download_url = f'https://chromedriver.storage.googleapis.com/{chrome_version}/chromedriver_{operating_sys}.zip'
  print(f'Downloading ChromeDriver for Chrome {chrome_version}...')

  # Download the ChromeDriver
  with requests.get(download_url, stream=True) as r:
    r.raise_for_status()
    with open('chromedriver.zip', 'wb') as f:
      for chunk in r.iter_content(chunk_size=8192):
        f.write(chunk)

  # Extract the ChromeDriver
  with zipfile.ZipFile(zip_path, 'r') as zip:
    zip.extractall(os.getcwd())
    if platform.system().lower() != 'windows':
      os.chmod(os.path.join(os.getcwd(), 'chromedriver'), 0o755)

  # Remove the zip file
  os.remove(zip_path)

def get_session():
  # Creates a new session
  res = requests.post(uri, json={
    "capabilities": {
      "alwaysMatch": {
        "acceptInsecureCerts": True
      }
    }
  }, headers=header)

  # Stores Session ID
  sessionId = res.json().get("value").get("sessionId")
  return sessionId

def browse_url(sessionId, url: str):
  # Browse to a URL
  requests.post(f"{uri}/{sessionId}/url", json={
    "url": url,
  }, headers=header)

def take_screenshot(sessionId, url: str):
  browse_url(sessionId, url)
  # Take a screenshot
  res = requests.get(f"{uri}/{sessionId}/screenshot", headers=header)
  image = res.json().get("value")

  # Saves the image to a screenshot.png file
  with open('screenshot.png', "wb") as fh:
    fh.write(base64.b64decode(image.encode("ASCII")))

if __name__ == "__main__":
  if platform.system().lower() != 'windows':
    driver = 'chromedriver'
  else:
    driver = 'chromedriver.exe'

  if not os.path.exists(driver):
    download_driver()

  # Start the webDriver server
  subprocess.Popen([os.path.join(os.getcwd() , driver), '--port=3333'], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  # Wait for the server to start
  time.sleep(3)

  sessionId = get_session()

  # Take Screenshot of the page
  take_screenshot(sessionId, "https://www.google.com")
