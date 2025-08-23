#!/usr/bin/env zsh

# More zsh completions
fpath=(/usr/share/zsh/plugins/zsh-completions/src $fpath)

# Load modules & initialize
zmodload zsh/complist
autoload -Uz compinit
autoload -Uz colors; colors

# Completion dump file location
zcompdumpfile="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
zcompdumpzwc="${zcompdumpfile}.zwc"

# Only run compinit if dump file is missing or older than 24h
if [[ ! -f $zcompdumpfile || ! -s $zcompdumpfile || $zcompdumpfile -nt $zcompdumpfile(#qN.mh+24) ]]; then
  compinit -i -d "$zcompdumpfile"
else
  compinit -C -d "$zcompdumpfile"
fi

# Compile only if needed
if [[ ! -f $zcompdumpzwc || $zcompdumpfile -nt $zcompdumpzwc ]]; then
  zcompile "$zcompdumpfile"
fi

# Show dotfiles in completion results
_comp_options+=(globdots)

# Use these completers in order
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:-command-:*' tag-order 'functions:-no-comp *' functions
zstyle ':completion:*:functions-no-comp' ignored-patterns '_*'

# Completors for autocorrect
# zstyle ':completion:*:corrections' completer _approximate _correct
# zstyle ':completion:*:correct' insert-unambiguous true
# zstyle ':completion:*:correct' ignored-patterns '_*' 'zsh*'
# zstyle ':completion:*:approximate:*' max-errors 1

# Enable option completion for commands like `cd -P`
zstyle ':completion:*' complete-options true

# Enable full completion (not just suggestions)
zstyle ':completion:*' complete true

# Use completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"

# File sorting: show most recently modified files first
zstyle ':completion:*' file-sort modification

# Menu-based selection UI for completion
zstyle ':completion:*' menu select

# Keep prefix like `./` when completing paths
zstyle ':completion:*' keep-prefix true

# Don't collapse multiple slashes in paths
zstyle ':completion:*' squeeze-slashes false

# Use LS_COLORS for file highlighting in menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Auto-description in completion menu
zstyle ':completion:*' auto-description '%d'

# Message formatting
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Verbose descriptions
zstyle ':completion:*' verbose yes

# Use group names in completion listings
zstyle ':completion:*' group-name ''

# Group completions for commands
zstyle ':completion:*:*:-command-:*:*' group-order \
    local-directories named-directories files \
    aliases builtins functions commands

# Tag order
# zstyle ':completion:*:-command-:*' tag-order \
#   'local-directories' 'named-directories' 'files'\
#   'aliases builtins functions commands'

# Skip menu when only one match (e.g., directory exists)
zstyle ':completion:*:local-directories' accept-exact true

# Give local directories their own color in the menu
zstyle ':completion:*:local-directories' list-colors '=(#b)*=1;34'

# Matcher list for fuzzy / smart completion
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*' \
  'm:{a-z}={A-Z} r:|=*'

# Kill process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=01;31'
zstyle ':completion:*:*:kill:*' menu yes select

# Create a widget to expand aliases on demand (Ctrl-X a)
zle -C alias-expansion complete-word _generic
bindkey '^Xa' alias-expansion

# Use _expand_alias completer for this widget only
zstyle ':completion:alias-expansion:*' complete true
zstyle ':completion:alias-expansion:*' completer _expand_alias
