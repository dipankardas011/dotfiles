# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

source ~/.git-prompt.sh


black='\[\e[30m\]' 
BLACK='\[\e[90m\]' 
red='\[\e[31m\]' 
RED='\[\e[91m\]' 
green='\[\e[32m\]' 
GREEN='\[\e[92m\]' 
yellow='\[\e[33m\]' 
YELLOW='\[\e[93m\]' 
blue='\[\e[34m\]' 
BLUE='\[\e[94m\]' 
mauve='\[\e[35m\]' 
MAUVE='\[\e[95m\]' 
cyan='\[\e[36m\]' 
CYAN='\[\e[96m\]' 
BOLD_CYAN='\[\e[1;36m\]'
white='\[\e[37m\]' 
WHITE='\[\e[0;97m\]' 

export GIT_PS1_SHOWDIRTYSTATE=1  # Show * for modified files, + for staged files
export GIT_PS1_SHOWSTASHSTATE=1  # Show $ if something is stashed
export GIT_PS1_SHOWUNTRACKEDFILES=1  # Show % if untracked files are present
export GIT_PS1_SHOWUPSTREAM="auto"  # Show <, >, = if branch is ahead, behind, or diverged

set_bash_prompt() {
    if [ $EUID = 0 ]; 
    then 
	PS1="${RED}\u${white}@${GREEN}\h ${CYAN}\W${white}${WHITE}\\$ " 
    else 
	PS1="${blue}\w${YELLOW}$(__git_ps1 ' |%s|')${WHITE} ${BOLD_CYAN}\\$ ${WHITE}" 
    fi 
}

PROMPT_COMMAND=set_bash_prompt

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR="nvim"

export PATH="/opt/apache-maven-3.8.5/bin:$PATH"

export PATH="$PATH:/opt/gradle/gradle-7.4.2/bin"
alias l='ls -l'
alias la='ls -la'
alias gpo='git push origin'
alias gplo='git pull origin'
alias g='git'
alias gcs='git commit -s'
alias cls='clear'

alias v='nvim'

alias onedrivePull='rclone sync -P onedrive: ~/Onedrive'
alias onedrivePush='rclone sync -P ~/Onedrive onedrive:'
alias gdrivePull='rclone sync -P gdrive: ~/GoogleDrive'
alias gdrivePush='rclone sync -P ~/GoogleDrive gdrive:'

export PATH=$PATH:/home/dipankar/.linkerd2/bin

export pager="delta"


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
export PATH="$HOME/bin:/usr/local/bin:$PATH"

alias ls='lsd'

alias pynbtopdf='jupyter-nbconvert --to pdf'

alias batmode='sudo sed -i s/TLP_DEFAULT_MODE=AC/TLP_DEFAULT_MODE=BAT/g /etc/tlp.conf && sudo tlp start'

alias acmode='sudo sed -i s/TLP_DEFAULT_MODE=BAT/TLP_DEFAULT_MODE=AC/g /etc/tlp.conf && sudo tlp start'

export GPG_TTY=$(tty)
fpath=($fpath "/home/dipankar/.zfunctions")

export PATH="$PATH:$HOME/.npm-global/bin:$HOME/.cargo/env"

alias openpdf="evince"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
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

alias ve="fd --type f --hidden --exclude .git | fzf-tmux | xargs nvim"

export SKIP_PACKAGE_CHECK=1

alias t="tmux"

alias pbcopy="xsel --clipboard --input"

alias nixinstall="nix profile install"
alias nixallupgrade="nix profile upgrade --all"

alias switchtohdmi="xrandr --output HDMI-1 --primary && xrandr --output eDP-1 --off"
alias switchtolaptop="xrandr --output eDP-1 --primary --auto && xrandr --output HDMI-1 --off"
