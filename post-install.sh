#!/bin/sh

set -ouex pipefail

systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer

systemctl --global enable flatpak-user-update.timer

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

cp /usr/share/ublue-os/ublue-os-update-services/etc/rpm-ostreed.conf /etc/rpm-ostreed.conf
