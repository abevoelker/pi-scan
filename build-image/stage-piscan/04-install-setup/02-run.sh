#!/bin/bash -e

. "${BASE_DIR}/config"

HOME="${ROOTFS_DIR}/home/${FIRST_USER_NAME:='pi'}"
install -m 755 -o 1000 -g 1000 files/run-pi-scan.sh  "${HOME}/pi-scan/"
install -m 755 -o 1000 -g 1000 files/config.ini      "${HOME}/.kivy/"
