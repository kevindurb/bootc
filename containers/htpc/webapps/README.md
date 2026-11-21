# HTPC web apps

These are installed **system-wide** into `/usr/share/applications` and
`/usr/share/icons/hicolor/512x512/apps`, so every user on every HTPC built from
this image gets them, and updates arrive with `bootc upgrade`.

The Bigscreen launcher and its Tasks view resolve a webapp window by its
Wayland app-id, which the runtime derives from `--name`.  Keeping the
`.desktop` basename, `X-KDE-Bigscreen-Webapp-Id`, and the app-id identical is
what makes the task entry show the right name and icon instead of
`plasma-bigscreen-webapp`.

## Adding a web app

1. Drop a square PNG (512x512 preferred) in `icons/` named
   `bigscreen-webapp-<id>.png`.

2. Add `applications/bigscreen-webapp-<id>.desktop`:

   ```ini
   [Desktop Entry]
   Type=Application
   Name=<display name>
   Exec=plasma-bigscreen-webapp --name "<display name>" <url>
   Icon=bigscreen-webapp-<id>
   URL=<url>
   X-KDE-Bigscreen-Webapp-Id=<id>
   X-KDE-Bigscreen-Webapp-UserAgent=
   ```

3. `<id>` must be exactly what the runtime derives from the display name
   (see `webappIdFromName()` in plasma-bigscreen): lowercase, spaces become
   `_`, and `/ " ' , . |` are removed.  Examples: `Netflix` -> `netflix`,
   `Disney Plus` -> `disney_plus`.

   **Do not use `+` in the name.** The app uses the name in a DBus object path,
   and `+` is invalid there, so the app exits at startup.

4. Rebuild the image and run `bootc upgrade` on the HTPCs.

## Per-box extras

Web apps added through Bigscreen's settings UI are stored per-user in
`~/.local/share/applications` and still work, but they get UUID ids and will
show as `plasma-bigscreen-webapp` in Tasks.  For anything that should be on all
HTPCs, add it here instead.
