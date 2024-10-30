#! /bin/bash
set -euo pipefail

dnf install -y tailscale
systemctl enable tailscaled.service
