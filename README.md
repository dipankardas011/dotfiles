# My all Linux configs

For installing run this

```bash
curl -fsSL https://dipankardas011.github.io/dotfiles/install.sh | sh
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

