#!/bin/bash -e

. "${BASE_DIR}/config"

install -m 755 files/mount_unionfs "${ROOTFS_DIR}/usr/local/bin/"

HOME="${ROOTFS_DIR}/home/${FIRST_USER_NAME:='pi'}"
#install -m 644 -o 0 -g 0       files/config.txt      "${ROOTFS_DIR}/boot/"
install -m 644 -o 0 -g 0       files/55-udisks2.pkla "${ROOTFS_DIR}/etc/polkit-1/localauthority/50-local.d/"
install -m 644 -o 0 -g 0       files/99-usb.rules    "${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 -o 0 -g 0       files/autologin.conf  "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/"
#install -m 755 -o 1000 -g 1000 files/firstrun.sh     "${HOME}/"
install -m 644 -o 1000 -g 1000 files/.xinitrc        "${HOME}/"
install -m 755 -o 1000 -g 1000 files/x11-boot.sh     "${HOME}/"
install -m 755 -o 1000 -g 1000 files/splash.png      "${HOME}/"
