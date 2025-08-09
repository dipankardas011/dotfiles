# My all Linux configs

> **Note**
> All the settings are done in Fedora 36 GNOME by installing
> 
> for guassian blur
> convert 2022-06-10-14-28-37-forest.jpg -blur 0x25 lock-forest.png

```sh
sudo dnf install @i3
sudo dnf install i3-gaps
```

- [x] i3
- [x] neovim
- [x] vim
- [x] rofi
- [x] polybar
- [x] picom
- [x] alacritty

https://github.com/adi1090x/polybar-themes

> **NOTE**
> Before running `./install.sh` do make backups


to make the capslock to esc

> **Notes**
```bash
vi /etc/X11/xorg.conf.d/00-keyboard.conf

localectl set-x11-keymap in '' '' caps:escape_shifted_capslock
```

```bash
# for the fonts install the required ones
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
git clone https://github.com/ronniedroid/getnf.git
cd getnf
chmod +x ./install.sh
./install.sh

# install lates firacode as well

fc-cache -f -v
.config/fontconfig/fonts.conf
```

[for zshrc plugins](https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df)

```bash
sudo dnf install -y autoconf automake cairo-devel fontconfig gcc libev-de
vel libjpeg-turbo-devel libXinerama libxkbcommon-devel libxkbcommon-x11-devel li
bXrandr pam-devel pkgconf xcb-util-image-devel xcb-util-xrm-devel

git clone https://github.com/Raymo111/i3lock-color.git\ncd i3lock-color
./build.sh
./install-i3lock-color.sh

betterlockscreen -u ~/.config/i3/images/bg_6.jpg
```


for the x11 scaling the i3
```bash
xrdb -merge ~/.Xresources
```
