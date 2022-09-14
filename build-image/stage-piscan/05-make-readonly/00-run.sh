#!/bin/bash -e

. "${BASE_DIR}/config"

install -m 755 -o 0 -g 0 files/firstboot "${ROOTFS_DIR}/usr/lib/raspberrypi-sys-mods/"
