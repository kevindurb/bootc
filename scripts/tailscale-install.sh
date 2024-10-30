#! /bin/bash

dnf install -y tailscale
systemctl enable tailscaled.service
