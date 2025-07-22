# Clear
alias c="clear"
alias cl="clear"
alias clr="clear"
alias cls="clear"

# Change Directories
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."

# Git Commands
alias gs="git status"
alias gss="git status -s"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gam="git commit --amend"
alias gp="git push"
alias gpo="git push origin"
alias gl="git pull"
alias gco="git chechout"
alias gcb="git checkout -b"
alias gcm="git checkout main"
alias gb="git branch"
alias gba="git branch -a"
alias gr="git reset"
alias grh="gir reset --hard"
alias gcl="git clone"
alias gd="git diff"
alias gdc="git diff --cached"
alias gpl="git pull"
alias gundo="git reset --soft HEAD~1"
alias glog="git log --online --graph --decorate --all"
alias gclean="git clean -fd"

# Grep
alias grep="grep -P -i --color=auto"

# History
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep="history | grep"

# List
alias els="eza -x -icons=always --color=always --hyperlink"
alias ell="eza -lahB --git --icons=always --color=always"
alias ls="ls --color=auto"
alias ll="ls -larth --color=auto"

# Confirmation
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'
alias rm='rm -I --preserve-root'
alias rmd='rm -Irf --preserve-root'

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Network
alias flighton='sudo rfkill block all'
alias flightoff='sudo rfkill unblock all'
alias snr='sudo service network-manager restart'
alias pg='ping 8.8.8.8'
alias port="netstat -tulpn | grep"
alias ports='sudo netstat -tulanp'1 #Open ports
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# Volume
alias vol='wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias micvol='wpctl get-volume @DEFAULT_AUDIO_SOURCE@'
alias volstatus='wpctl status | less'
alias volnow='wpctl status | grep -A3 "Audio/Sink" | grep -E "^\s*🔊|Volume"'
alias vol50='wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.5'
alias volup='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'
alias voldown='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'
alias volmute='wpctl set-mute @DEFAULT_AUDIO_SINK@ 1'
alias volunmute='wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'

# Dotfiles
alias dot='git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'

# Pacman
alias pacup='sudo pacman -Syu'
alias pacsyu='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacsr='sudo pacman -Ss'
alias pacqi='pacman -Qi'
alias pacql='pacman -Ql'
alias pacown='pacman -Qo'
alias pacorph='sudo pacman -Rns $(pacman -Qtdq)'
alias pacclean='sudo pacman -Sc'
alias paccleanall='sudo pacman -Scc'
alias paclist='pacman -Qe'

# Yay (AUR)
alias yayup='yay -Syu'
alias yayin='yay -S'
alias yayrm='yay -Rns'
alias yaysr='yay -Ss'
alias yayqi='yay -Qi'
alias yayql='yay -Ql'
alias yayown='yay -Qo'
alias yayorph='yay -Rns $(yay -Qtdq)'
alias yayclean='yay -Sc'
alias yaycleanall='yay -Scc'
alias yaylist='yay -Qe'

# Storage
alias dust='du -sh | sort -hr'

# System
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'


# Tmux
alias tm='tmux attach || tmux new'
alias tmnew='tmux new -s'
alias tmls='tmux ls'
alias tma='tmux attach -t'
alias tmkill='tmux kill-session -t'
alias tmkillall='tmux kill-server'
alias tmrename='tmux rename-session -t'
