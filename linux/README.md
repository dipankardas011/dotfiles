## Linux configurations

`OS`: Fedora 41 i3

`Status`: :work-in-progress:


for the changes in the font from gtk-3.0

~/.config/gtk-3.0/settings.ini

```bash
flatpak override --user --env=__NV_PRIME_RENDER_OFFLOAD=1 com.obsproject.Studio
flatpak override --user --env=__GLX_VENDOR_LIBRARY_NAME=nvidia com.obsproject.Studio\n
```


For discord and slack but not working with screensharing
`--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland`


```cfg
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
# GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
# GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init earlyprintk=vga"
GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1 rhgb quiet nvidia-drm.modeset=1 rd.driver.blacklist=nouveau modprobe.blacklist=nouveau"
#GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1 rhgb quiet initcall_blacklist=simpledrm_platform_driver_init nvidia-drm.modeset=1"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
```
