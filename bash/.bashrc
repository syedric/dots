#!/usr/bin/env bash

# Avoid duplicate sourcing
[[ $- != *i* ]] && return

source "$HOME/bashrc.d/bprofile"
source "$HOME/bashrc.d/options"
source "$HOME/bashrc.d/bash-powerline"
source "$HOME/bashrc.d/functions"
source "$HOME/bashrc.d/tools"
source "$XDG_CONFIG_HOME/misc/lscolors"
source "$XDG_CONFIG_HOME/misc/aliases"

