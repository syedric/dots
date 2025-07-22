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
alias glog"git log --online --graph --decorate --all"
alias gclean="git clean -fd"

# History
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep"history | grep"

# List
alias els="eza -x -icons=always --color=always --hyperlink"
alias ell="eza -lahB --git --icons=always --color=always"
alias ls="ls --color=auto"
alias ll="ls -larth -color=auto"

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -I --preserve-root'

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Network
alias flighton='sudo rfkill block all'
alias flightoff='sudo rfkill unblock all'
alias snr='sudo service network-manager restart'
alias ports='sudo netstat -tulanp'1 #Open ports

