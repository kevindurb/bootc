#! /usr/bin/env bash
set -euo pipefail

dnf5 install -y dnf5-plugins
dnf5 copr enable -y atim/lazygit
dnf5 copr enable -y atim/starship
dnf5 install -y \
  alacritty \
  bat \
  bc \
  curl \
  diff \
  diffutils \
  duf \
  entr \
  eza \
  fastfetch \
  find \
  findmnt \
  fzf \
  gh \
  git \
  git-delta \
  git-extras \
  gnupg2 \
  go-task \
  golang \
  gpg \
  gstreamer1-plugin-libav \
  gstreamer1-plugin-openh264 \
  gstreamer1-plugins-bad-free \
  gstreamer1-plugins-base \
  gstreamer1-plugins-good \
  gstreamer1-plugins-ugly-free \
  heif-pixbuf-loader \
  htop \
  httpie \
  jq \
  just \
  kubectl \
  lazygit \
  litecli \
  lolcat \
  mycli \
  ncdu \
  neovim \
  nyancat \
  pgcli \
  prettyping \
  pv \
  python-pip \
  python3-pip \
  ripgrep \
  rsync \
  snapd \
  starship \
  syncthing \
  tailscale \
  tig \
  tldr \
  tmux \
  toolbox \
  wget \
  wl-clipboard \
  yq \
  zoxide \
  zsh
dnf5 clean all

systemctl --global enable syncthing.service
systemctl enable tailscaled.service
systemctl enable snapd.service
/usr/bin/ln -sf /var/lib/snapd/snap /