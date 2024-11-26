#! /bin/bash
set -euo pipefail

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/bin
