#! /bin/bash
set -euo pipefail

wget https://openrgb.org/releases/release_0.9/60-openrgb.rules
mv 60-openrgb.rules /usr/lib/udev/rules.d
