#!/bin/bash -e

# Enable auto-login
# https://github.com/RPi-Distro/raspi-config/blob/cd86846921953b39faf7cf48bb9dd187240094e5/raspi-config#L1403
systemctl --quiet set-default multi-user.target
touch /home/${FIRST_USER_NAME:='pi'}/.hushlogin

# Disabled until I understand its purpose better:
#cat <<EOT >> /etc/fstab
#mount_unionfs   /etc            fuse    defaults          0       0
#mount_unionfs   /var            fuse    defaults          0       0
#mount_unionfs   /home           fuse    defaults          0       0
#mount_unionfs   /media          fuse    defaults          0       0
#EOT

cat <<EOT >> /home/${FIRST_USER_NAME:='pi'}/.profile

# Silent startx on video console
#if [[ -z \$DISPLAY && \$XDG_VTNR -eq 1 ]]; then
#  startx > /dev/null 2>&1
#  exit
#fi

# Start Pi Scan
~/pi-scan/run-pi-scan.sh
EOT
