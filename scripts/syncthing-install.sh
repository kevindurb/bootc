#! /bin/bash
set -euo pipefail

dnf install -y syncthing
systemctl enable syncthing.service
