#! /bin/bash
set -euo pipefail

dnf5 install -y dnf-plugins

dnf5 copr enable atim/lazygit -y
dnf5 copr enable atim/starship -y

dnf5 install -y \
  alacritty \
  wl-clipboard \
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
  starship \
  tig \
  tldr \
  tmux \
  toolbox \
  wget \
  yq \
  zoxide \
  zsh
