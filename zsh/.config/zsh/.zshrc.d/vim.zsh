#!/usr/bin/env zsh

# Vi keybindings
bindkey -v
export KEYTIMEOUT=10

# Cursor Mode Setup
function cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'
    
    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] || [[ $1 == 'block' ]]; then
            printf "$cursor_block"
            # RPROMPT="%F{blue}[N]%f"
        elif [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == main ]] || [[ -z ${KEYMAP} ]] || [[ $1 == 'beam' ]]; then
            printf "$cursor_beam"
            # RPROMPT="%F{green}[I]%f"
        fi
        # zle reset-prompt
    }
    
    function zle-line-init {
        printf "$cursor_beam"
	# RPROMPT="%F{green}[I]%f"
	# zle reset-prompt
    }
    
    zle -N zle-keymap-select
    zle -N zle-line-init
    
    # Reset cursor to block on shell exit
    # TRAPEXIT() {
    #     echo -ne '\e[2 q'
    # }
    
    # Set initial cursor to beam
    # echo -ne "$cursor_beam"
}
cursor_mode

# Sync zsh internal clipboard with system
copy-to-clipboard() {
  zle copy-region-as-kill
  print -rn -- "$CUTBUFFER" | wl-copy
}
zle -N copy-to-clipboard

# Vim-style navigation in completion menus
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M visual 'y' copy-to-clipboard       # Yank
bindkey -M visual 'd' kill-region             # Delete
bindkey -M vicmd 'p' vi-put-after             # Paste
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Use Tab / Shift-Tab in menu
# bindkey -M menuselect '^I' down-line-or-history     # Tab
# bindkey -M menuselect '^[[Z' up-line-or-history     # Shift-Tab

# Fallback editor setup
export VISUAL=${VISUAL:-vim}
export EDITOR=${EDITOR:-vim}
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '\ee' edit-command-line

# Text Object Selection
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed

quoted_chars=( "'" '"' '`' '|' ',' '.' '/' ':' ';' '=' '+' '@' )
bracketed_chars=( '(' ')' '[' ']' '{' '}' '<' '>' 'b' 'B' )

for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in a i; do
    for q in $quoted_chars; do
      bindkey -M $km "${c}${q}" select-quoted
    done
    for b in $bracketed_chars; do
      bindkey -M $km "${c}${b}" select-bracketed
    done
  done
done
