## xdg-desktop-portal in latest fedora 44 didnt't work

and crashed resulting in some desktop guis not responding to the dark theme

so that the screenshare and other things do work

Ghostty frequently closing or crashing in Hyprland
with UWSM (Unified Wayland Session Manager) is usually
caused by an issue with GTK Single Instance Mode or D-Bus activation.
Since Ghostty assumes it's being launched from a desktop environment,
it can close itself or terminate all open terminal windows if it drops a background process.

This is a known regression in xdg-desktop-portal 1.22.0 (which came with your Fedora 43→44 upgrade). The upstream
 (flatpak/xdg-desktop-portal) added Requisite=graphical-session.target in the systemd unit. This means:

 - The portal service requires graphical-session.target to be already active before it starts
 - Hyprland (unlike GNOME) does not activate graphical-session.target
 - So xdg-desktop-portal.service fails silently → no screen sharing works

 This is widely reported:
 - flatpak/xdg-desktop-portal#2024 (screen sharing broken on Hyprland)
 - flatpak/xdg-desktop-portal#1983 (originally reported on Fedora 44 MATE!)
 - Hyprland discussion #15072 (confirmed by Hyprland maintainer)
 - mylinuxforwork/dotfiles#1663 (same fix documented)

fix for now was

```service
cat /usr/lib/systemd/user/xdg-desktop-portal.service
[Unit]
Description=Portal service
PartOf=graphical-session.target
#Requisite=graphical-session.target

Requires=dbus.service
After=dbus.service

After=graphical-session.target


[Service]
Type=dbus
BusName=org.freedesktop.portal.Desktop
ExecStart=/usr/libexec/xdg-desktop-portal
Slice=session.slice
```
