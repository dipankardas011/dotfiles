# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes





ZSH_THEME="robbyrussell"
NPM_CONFIG_PREFIX='~/.npm-global'
KUBE_PS1_SEPARATOR=" |"
KUBE_PS1_PREFIX_COLOR="yellow"
KUBE_PS1_SUFFIX_COLOR="yellow"
KUBE_PS1_SEPARATOR_COLOR="magenta"

KUBE_PS1_CTX_COLOR="red"
KUBE_PS1_SYMBOL_CUSTOM="k8s"
# KUBE_PS1_CTX_COLOR="magenta"






# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    kube-ps1
    kubectl
    docker
)

source $ZSH/oh-my-zsh.sh

# PROMPT='$(kube_ps1)'$'\n'$PROMPT
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR="nvim"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export PATH=/opt/apache-maven-3.8.5/bin:$PATH

export PATH=$PATH:/opt/gradle/gradle-7.4.2/bin
alias l='ls -l'
alias la='ls -la'
alias gpo='git push origin'
alias gplo='git pull origin'
alias g='git'
alias gcs='git commit -s'
alias cls='clear'

alias v='nvim'
# alias vi='lvim'

alias gdrivePull='rclone sync -P gdrive: ~/GoogleDrive'
alias gdrivePush='rclone sync -P ~/GoogleDrive gdrive:'
alias s3Push='rclone sync -P ~/ext-bkps/s3 s3:'
alias s3Pull='rclone sync -P s3: ~/ext-bkps/s3'

export PATH=$PATH:/home/dipankar/.linkerd2/bin

export pager="delta"


export PATH=$PATH:/home/dipankar/Desktop/OPS/kubernetes/third_party/etcd


# speedscale env vars
export SPEEDSCALE_HOME=/home/dipankar/.speedscale
export PATH=$PATH:$SPEEDSCALE_HOME


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH="$PATH:/home/dipankar/istio-1.18.0/bin"

alias d=docker


alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"


alias createNode='echo "---\nauthor: Dipankar Das\n---\n" > notes-$(date +%d-%m-%Y).md'

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

complete -C '/usr/local/bin/aws_completer' aws
alias ls='lsd'

alias pynbtopdf='jupyter-nbconvert --to pdf'

alias mirrordisplay='xrandr --output "eDP-1" --auto --output "HDMI-1" --same-as "eDP-1"'

alias normaldisplay='xrandr --output "eDP-1" --auto'

# alias conservativemode='sudo sed -i s/STOP_CHARGE_THRESH_BAT0=0/STOP_CHARGE_THRESH_BAT0=1/g /etc/tlp.conf && sudo tlp start'
# alias normalmode='sudo sed -i s/STOP_CHARGE_THRESH_BAT0=1/STOP_CHARGE_THRESH_BAT0=0/g /etc/tlp.conf && sudo tlp start'

alias batmode='sudo sed -i s/TLP_DEFAULT_MODE=AC/TLP_DEFAULT_MODE=BAT/g /etc/tlp.conf && sudo tlp start'

alias acmode='sudo sed -i s/TLP_DEFAULT_MODE=BAT/TLP_DEFAULT_MODE=AC/g /etc/tlp.conf && sudo tlp start'

export GPG_TTY=$(tty)
fpath=($fpath "/home/dipankar/.zfunctions")

export PATH="$PATH:$HOME/.npm-global/bin:$HOME/.cargo/env"

export PATH=/home/dipankar/.groundcover/bin:${PATH}

alias openpdf="evince"


export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

# Wasmer
export WASMER_DIR="/home/dipankar/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

export PATH="$PATH:$HOME/.protobuff/bin"

alias tf="terraform"

alias soundControl="pavucontrol"

alias github="cd ~/Onedrive/github"
alias gitlab="cd ~/Onedrive/gitlab"

export TERM="xterm-256color"

alias dksctl="cd ~/Desktop/OPS/ksctl"
alias dp="cd ~/Desktop/OPS"

. "/home/dipankar/.wasmedge/env"

alias ve="fd --type f --hidden --exclude .git | fzf-tmux -m -p | xargs nvim"

alias t="tmux"

alias pbcopy="xsel --clipboard --input"

alias nixinstall="nix profile install"
alias nixallupgrade="nix profile upgrade --all"

# alias switchtohdmi="xrandr --output HDMI-1 --primary && xrandr --output eDP-1 --off"
# alias switchtolaptop="xrandr --output eDP-1 --primary --auto && xrandr --output HDMI-1 --off"
alias switchtohdmi='
if xrandr | grep "HDMI-1 connected"; then
  xrandr --output HDMI-1 --primary --auto && xrandr --output eDP-1 --off
else
  echo "HDMI-1 is not connected."
fi
'

alias switchtolaptop='
if xrandr | grep "eDP-1 connected"; then
  xrandr --output eDP-1 --primary --auto && xrandr --output HDMI-1 --off
else
  echo "eDP-1 is not connected."
fi
'
