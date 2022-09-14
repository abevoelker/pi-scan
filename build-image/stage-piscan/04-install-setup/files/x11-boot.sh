#!/usr/bin/env bash

# never blank the screen
xset s off -dpms

# show a splash before app starts up
feh --bg-scale splash.png

# Start Pi Scan
while true; do
  cd /home/pi/pi-scan
  python main.py
done;
