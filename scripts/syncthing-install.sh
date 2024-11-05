#! /bin/bash
set -euo pipefail

dnf install -y syncthing
systemctl --user enable syncthing.service
