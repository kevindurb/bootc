#! /bin/bash
set -euo pipefail

dnf install -y syncthing
systemctl --global enable syncthing.service
