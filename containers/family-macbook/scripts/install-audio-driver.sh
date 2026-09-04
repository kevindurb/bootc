#!/bin/bash
set -euo pipefail

dnf5 install --assumeyes \
  gcc \
  make \
  patch \
  git

# Fedora prunes old kernel-devel builds from the repos faster than the base
# image's pinned kernel gets archived, so pin to the base kernel and fall
# back to upgrading kernel+kernel-devel together (in sync with each other,
# not with the base image) when that exact build is gone.
KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)
if ! dnf5 install --assumeyes "kernel-devel-${KERNEL_VER}"; then
  dnf5 install --assumeyes --allowerasing \
    kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-devel
  KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)
fi

git clone https://github.com/davidjo/snd_hda_macbookpro /tmp/mac-audio

# The upstream Makefile's install target calls unversioned `depmod -a`, which
# fails in a container build where the runner kernel differs from the target.
sed -i "s/depmod -a$/depmod -a ${KERNEL_VER}/" /tmp/mac-audio/Makefile

cd /tmp/mac-audio
bash install.cirrus.driver.sh -k "${KERNEL_VER}"

dnf5 clean all
rm -rf /tmp/mac-audio
