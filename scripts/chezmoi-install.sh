#! /bin/bash

/usr/bin/curl -fLs --create-dirs \
  https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-linux-amd64 \
  -o /usr/bin/chezmoi

/usr/bin/chmod 755 /usr/bin/chezmoi
