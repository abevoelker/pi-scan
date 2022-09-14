#!/bin/bash -e

. "${BASE_DIR}/config"
on_chroot << EOF
# Disable default user password
echo -n "${FIRST_USER_NAME:='pi'}:" > /boot/userconf.txt
passwd -d ${FIRST_USER_NAME:='pi'}

# Disable swap
dphys-swapfile swapoff
dphys-swapfile uninstall
systemctl disable dphys-swapfile

# Enable tmpfs
cp /usr/share/systemd/tmp.mount /etc/systemd/system/
systemctl enable tmp.mount

# Disable screen blanking
sed -i '$ s/$/ consoleblank=0/' /boot/cmdline.txt
mkdir -p -m 755 /etc/kbd
EOF

install -m 644 files/kbd-config "${ROOTFS_DIR}/etc/kbd/config"
