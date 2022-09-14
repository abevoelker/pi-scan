#!/bin/sh

sudo sh -c "TERM=linux setterm -blank 0 >/dev/tty0"

export CHDKPTP_DIR="/home/pi/chdkptp.py/chdkptp/vendor/chdkptp"
while true; do
  cd /home/pi/pi-scan
  python main.py
done;
