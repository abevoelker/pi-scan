#!/bin/bash -e

. "${BASE_DIR}/config"
on_chroot << EOF
# Install Python 2.7 Pip
cd /tmp
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py

# Install Pillow 4.0
pip install Pillow==4.0.0
EOF
