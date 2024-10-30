#! /bin/bash
set -euo pipefail

dnf remove -y power-profiles-daemon
dnf install -y powertop tuned
systemctl enable tuned
