#!/bin/sh

set -ouex pipefail

#systemctl enable rpm-ostreed-automatic.timer
#systemctl enable flatpak-system-update.timer

#systemctl --global enable flatpak-user-update.timer

# mask rfkill and ppd for tlp to work
#systemctl mask systemd-rfkill.service systemd-rfkill.socket power-profiles-daemon.service
#systemctl enable tlp.service

#systemctl preset-all
#systemctl --user preset-all

cp /usr/share/ublue-os/ublue-os-update-services/etc/rpm-ostreed.conf /etc/rpm-ostreed.conf
