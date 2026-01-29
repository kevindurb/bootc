#! /usr/bin/env bash
set -euo pipefail

dnf5 install -y \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo

dnf5 install --assumeyes dnf5-plugins

dnf5 install --assumeyes \
  --exclude plasma-discover-snap \
  @development-tools \
  curl \
  diff \
  distrobox \
  ffmpeg \
  find \
  findmnt \
  git \
  gnupg2 \
  gpg \
  gstreamer1-plugin-dav1d \
  gstreamer1-plugin-libav \
  gstreamer1-plugin-openh264 \
  gstreamer1-plugins-bad-free \
  gstreamer1-plugins-base \
  gstreamer1-plugins-good \
  gstreamer1-plugins-ugly-free \
  heif-pixbuf-loader \
  mullvad-vpn \
  pv \
  python-pip \
  python3-pip \
  rsync \
  snapd \
  syncthing \
  tailscale \
  toolbox \
  wget \
  wireguard-tools \
  wl-clipboard \
  zsh

dnf5 clean all

systemctl --global enable syncthing.service
systemctl enable tailscaled.service
systemctl enable snapd.service
/usr/bin/ln -sf /var/lib/snapd/snap /
