#! /bin/bash
set -euo pipefail

dnf copr enable atim/lazygit -y
dnf copr enable atim/starship -y

dnf install -y \
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
  wget \
  yq \
  zoxide \
  zsh
