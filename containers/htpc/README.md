# HTPC image

## Login

Autologin is intentionally not configured: the Plasma login manager asks for
the user's password at boot and after wake (the latter is the lock screen).
`htpc-user-setup` repairs a missing home directory and clears legacy autologin
drop-ins.

## Flatpak apps

The set is declared in `/usr/share/htpc/flatpaks.list` and installed
system-wide from Flathub on first boot by `htpc-flatpaks.service`:

- Firefox
- VacuumTube
- Jellyfin Desktop
- Moonlight
- Steam
- Spotify
- SuperTuxKart
- KDE Weather

Flatpaks cannot be baked into the CI image because bubblewrap cannot create
namespaces inside the build container.  The service is idempotent, checks the
list on every boot, and retries failures; per-box extras go in
`/etc/htpc/flatpaks.list`.  Firefox here replaces the RPM that Kinoite removes.

`htpc-user-setup` shadows the Jellyfin Desktop launcher with
`--fullscreen --tv`, and the system Flatpak override grants `devices=all` and
`/run/udev:ro` so game controllers are visible inside the sandbox.

## Chrome web apps

Netflix, Disney Plus, Paramount Plus and Apple TV+ run in Google Chrome so
they get Widevine and H.264/AAC.  See `webapps/README.md` for the launcher
conventions, kiosk mode, and the Hide Scrollbar policy.
