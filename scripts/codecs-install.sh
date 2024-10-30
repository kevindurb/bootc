#! /bin/bash
set -euo pipefail

dnf install -y \
  gstreamer1-plugin-libav \
  gstreamer1-plugin-openh264 \
  gstreamer1-plugins-base \
  gstreamer1-plugins-good \
  heif-pixbuf-loader
