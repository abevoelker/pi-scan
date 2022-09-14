#!/bin/bash -e

. "${BASE_DIR}/config"
on_chroot << EOF
pip install -I Cython==0.23
pip install lupa --install-option="--no-luajit"

# Install WiringPi
# https://raspberrypi.stackexchange.com/questions/137316/how-to-install-wiringpi-on-raspbian
cd /tmp
wget https://project-downloads.drogon.net/wiringpi-latest.deb
dpkg -i wiringpi-latest.deb
rm wiringpi-latest.deb
EOF
