#!/bin/bash
set -euo pipefail

dnf5 install --assumeyes \
  gcc \
  make \
  git \
  curl \
  xz \
  cpio

# See install-audio-driver.sh for why this falls back to pinning the whole
# kernel package set to the latest available kernel-devel version.
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

# Build and install the facetimehd kernel module
git clone https://github.com/patjak/facetimehd /tmp/facetimehd
make -C "/usr/src/kernels/${KERNEL_VER}" M=/tmp/facetimehd modules
make -C "/usr/src/kernels/${KERNEL_VER}" M=/tmp/facetimehd \
  INSTALL_MOD_DIR=updates modules_install
depmod -a "${KERNEL_VER}"

# Extract firmware from Apple's OS X 10.11.5 update (downloads only the
# relevant byte range, not the full ~1.5 GB DMG)
git clone https://github.com/patjak/facetimehd-firmware /tmp/facetimehd-firmware
cd /tmp/facetimehd-firmware
make
make install

dnf5 clean all
rm -rf /tmp/facetimehd /tmp/facetimehd-firmware
