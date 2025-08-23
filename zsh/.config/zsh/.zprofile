#!/usr/bin/env zsh

# Additional Paths
export PATH="$PATH:$HOME/.local/bin:/usr/local/texlive/2025/bin/x86_64-linux"

# Man and Info Pages
export MANPATH=":/usr/local/texlive/2025/texmf-dist/doc/man"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:/usr/share/info"

# XDG Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME=$HOME/.cache

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

export PATH=$PATH:/usr/local/go/bin
