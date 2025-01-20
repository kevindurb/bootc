#! /usr/bin/env bash
set -euo pipefail

dnf5 install --assumeyes dnf5-plugins
dnf5 copr enable --assumeyes atim/lazygit
dnf5 copr enable --assumeyes atim/starship
dnf5 copr enable --assumeyes emanuelec/k9s

dnf5 install --assumeyes \
  alacritty \
  arm-image-installer \
  curl \
  diff \
  diffutils \
  distrobox \
  find \
  findmnt \
  git \
  gnupg2 \
  gpg \
  gstreamer1-plugin-libav \
  gstreamer1-plugin-openh264 \
  gstreamer1-plugins-bad-free \
  gstreamer1-plugins-base \
  gstreamer1-plugins-good \
  gstreamer1-plugins-ugly-free \
  heif-pixbuf-loader \
  pv \
  python-pip \
  python3-pip \
  rsync \
  snapd \
  syncthing \
  tailscale \
  toolbox \
  wget \
  wl-clipboard \
  zsh

dnf5 clean all

systemctl --global enable syncthing.service
systemctl enable tailscaled.service
systemctl enable snapd.service
/usr/bin/ln -sf /var/lib/snapd/snap /
