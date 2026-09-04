#!/bin/bash
set -euo pipefail

dnf5 install --assumeyes \
  gcc \
  make \
  patch \
  git

# Fedora prunes old kernel-devel builds from the repos faster than the base
# image's pinned kernel gets archived, so pin to the base kernel and fall
# back to moving the whole kernel package set to the latest available
# kernel-devel version (an `install` on already-installed kernel packages
# is a no-op, so they must be pinned to the same NVR to stay in sync).
KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)
if ! dnf5 install --assumeyes "kernel-devel-${KERNEL_VER}"; then
  KERNEL_VER=$(dnf5 repoquery --available --latest-limit 1 --qf '%{version}-%{release}.%{arch}' kernel-devel)
  dnf5 install --assumeyes --allowerasing \
    "kernel-${KERNEL_VER}" \
    "kernel-core-${KERNEL_VER}" \
    "kernel-modules-${KERNEL_VER}" \
    "kernel-modules-core-${KERNEL_VER}" \
    "kernel-modules-extra-${KERNEL_VER}" \
    "kernel-devel-${KERNEL_VER}"
fi

git clone https://github.com/davidjo/snd_hda_macbookpro /tmp/mac-audio

# The upstream Makefile's install target calls unversioned `depmod -a`, which
# fails in a container build where the runner kernel differs from the target.
sed -i "s/depmod -a$/depmod -a ${KERNEL_VER}/" /tmp/mac-audio/Makefile

cd /tmp/mac-audio
bash install.cirrus.driver.sh -k "${KERNEL_VER}"

dnf5 clean all
rm -rf /tmp/mac-audio
