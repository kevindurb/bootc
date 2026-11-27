#!/bin/bash
# Join the tailnet on first boot. The auth key is written to /run (tmpfs) by
# cloud-init (from the ci-runner-cloudinit SealedSecret) and consumed here
# once; afterwards it is shredded. On later boots /run is fresh and the key
# file is absent: tailscaled reconnects with its persisted state, so this
# is a no-op.
set -euo pipefail

if [ ! -f /run/tailscale-authkey ]; then
  echo "tailscale-up: no /run/tailscale-authkey, assuming already joined; skipping"
  exit 0
fi

tailscale up \
  --auth-key=file:/run/tailscale-authkey \
  --advertise-tags=tag:ci \
  --ssh \
  --accept-dns=true \
  --reset

shred -u /run/tailscale-authkey
