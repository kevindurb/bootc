#! /bin/bash

dnf remove -y power-profiles-daemon
dnf install -y powertop tuned
systemctl enable tuned
