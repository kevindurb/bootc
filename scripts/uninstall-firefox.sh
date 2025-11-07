#! /usr/bin/env bash
set -euo pipefail

dnf5 remove --assumeyes firefox

dnf5 clean all
