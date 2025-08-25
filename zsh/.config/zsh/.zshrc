#!/usr/bin/env zsh

source "$XDG_CONFIG_HOME/zsh/zshrc.d/options"
source "$XDG_CONFIG_HOME/zsh/zshrc.d/completions"
source "$XDG_CONFIG_HOME/zsh/zshrc.d/prompt"
source "$XDG_CONFIG_HOME/misc/lscolors"
source "$XDG_CONFIG_HOME/misc/aliases"

# ZSH Vi Mode Plugin
source /home/shams/.local/bin/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Fish like autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fast Syntax Highlighting
source /usr/share/zsh/plugins/fsh/fast-syntax-highlighting.plugin.zsh

source "$XDG_CONFIG_HOME/zsh/zshrc.d/tools"
