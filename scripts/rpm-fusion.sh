#! /bin/bash
set -euo pipefail

dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm
