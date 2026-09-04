#!/bin/bash
set -euo pipefail

dnf5 install --assumeyes \
  gcc \
  make \
  git \
  curl \
  xz \
  cpio

# See install-audio-driver.sh for why this falls back to upgrading
# kernel+kernel-devel together instead of pinning to the base image's kernel.
KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)
if ! dnf5 install --assumeyes "kernel-devel-${KERNEL_VER}"; then
  dnf5 install --assumeyes --allowerasing \
    kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-devel
  KERNEL_VER=$(rpm -q kernel --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -1)
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
