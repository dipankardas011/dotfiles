sudo dnf update --refresh -y

## NVIDIA driver

/sbin/lspci | grep -e VGA
/sbin/lspci | grep -e 3D

# for the nvidia driver
sudo dnf install kmodtool akmods mokutil openssl 
sudo kmodgenca -a 
sudo mokutil --import /etc/pki/akmods/certs/public_key.der 

systemctl reboot
sudo dnf update -y
clear
lsmod |grep nouveau
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda
modinfo -F version nvidia

lsmod |grep nouveau
lsmod |grep nvidia

## asusctl

dnf copr enable lukenukem/asus-linux 
sudo dnf install asusctl supergfxctl
sudo dnf install asusctl-rog-gui
sudo systemctl daemon-reload

sudo systemctl enable --now asusd.service
sudo systemctl restart asusd.service

sudo systemctl enable --now supergfxd.service
sudo systemctl restart supergfxd.service


## non-free distro

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install discord slack # for slack may be get the rpm download

## Docker

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER

sudo systemctl enable --now docker

## 1password

# get it from 1password documentation on the repo list to install

## NodeJS
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

## Golang
sudo dnf install golang

## Clipboard
sudo dnf copr enable azandure/clipse
sudo dnf install clipse


## hyprland

sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland \
    hyprpaper \
    hyprlock \
    tmux \
    waybar \
    wofi \
    wlogout \
    hyprland-devel \
    blueman \
    delta \
    readline-devel \
    git \
    gcc \
    zlib-devel \
    bzip2 \
    bzip2-devel \
    sqlite-devel \
    xz-devel \
    libffi-devel \
    wget \
    curl \
    pavucontrol \
    dunst \
    rclone \
    hypridle \
    nm-applet \
    xlsclients \
    hypridle \
    gnome-themes-extra \
    vdpauinfo

sudo dnf -y swap 'ffmpeg-free' 'ffmpeg' --allowerasing

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
sudo dnf install lxappearance

## zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## MPV
sudo dnf install mpv
sudo dnf install kmod-v4l2loopback

## Flatpak
flatpak install flathub org.signal.Signal
flatpak install flathub com.obsproject.Studio

## Sensors
sudo dnf install lm_sensors

## additional
sudo dnf copr enable atim/bottom -y
sudo dnf install bottom # btm
