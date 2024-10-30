#! /bin/bash
set -euo pipefail

dnf install -y snapd
systemctl enable snapd.service
/usr/bin/ln -sf /var/lib/snapd/snap /
