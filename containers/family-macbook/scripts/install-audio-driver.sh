#!/bin/bash
set -euo pipefail

KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)

dnf5 install --assumeyes \
  "kernel-devel-${KERNEL_VER}" \
  gcc \
  make \
  patch \
  git

git clone https://github.com/davidjo/snd_hda_macbookpro /tmp/mac-audio
cd /tmp/mac-audio
bash install.cirrus.driver.sh -k "${KERNEL_VER}"
depmod -a "${KERNEL_VER}"

dnf5 clean all
rm -rf /tmp/mac-audio
