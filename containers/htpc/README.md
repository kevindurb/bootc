# HTPC image

## Login

Autologin is intentionally not configured: the Plasma login manager asks for
the user's password at boot and after wake (the latter is the lock screen).
`htpc-user-setup` repairs a missing home directory and clears legacy autologin
drop-ins.

## Jellyfin Desktop

Jellyfin Desktop is a Flatpak, so it cannot be baked into the CI image:
bubblewrap cannot create namespaces inside the build container.  Instead:

- `htpc-jellyfin-flatpak.service` installs it system-wide from Flathub on first
  boot, then skips itself once `/var/lib/flatpak/app/org.jellyfin.JellyfinDesktop`
  exists.  This needs network access on the first boot.
- `htpc-user-setup` shadows the Flatpak launcher with
  `--fullscreen --tv`, so the Bigscreen launcher opens the TV interface.
- `/var/lib/flatpak/overrides/org.jellyfin.JellyfinDesktop` grants
  `devices=all` and `/run/udev:ro` so game controllers are visible inside the
  Flatpak sandbox.  Arrow keys from the K400 work without extra permissions.

## Chrome web apps

Netflix, Disney Plus, Paramount Plus and Apple TV+ run in Google Chrome so
they get Widevine and H.264/AAC.  See `webapps/README.md` for the launcher
conventions, kiosk mode, and the Hide Scrollbar policy.
