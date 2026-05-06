#!/bin/bash
set -euo pipefail

dnf5 install --assumeyes gcc make git

git clone https://github.com/dgraziotin/mbpfan /tmp/mbpfan
cd /tmp/mbpfan
make install
install -m644 mbpfan.service /lib/systemd/system/

dnf5 clean all
rm -rf /tmp/mbpfan
