#!/bin/bash -e

. "${BASE_DIR}/config"
on_chroot << EOF
# Install Kivy 1.11.0
pip install Kivy==1.11.0
EOF
