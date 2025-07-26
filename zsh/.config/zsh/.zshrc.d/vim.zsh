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
        elif [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == main ]] || [[ -z ${KEYMAP} ]] || [[ $1 == 'beam' ]]; then
            printf "$cursor_beam"
        fi
    }
    
    function zle-line-init {
        printf "$cursor_beam"
    }
    
    zle -N zle-keymap-select
    zle -N zle-line-init    
}
cursor_mode

# Sync zsh internal clipboard with system
autoload -Uz copy-region-as-kill
copy-to-clipboard() {
    if zle copy-region-as-kill; then
        print -rn -- "$CUTBUFFER" | wl-copy
    fi
    zle deactivate-region
}
zle -N copy-to-clipboard

# --- menuselect ---
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect ' ' accept-and-menu-complete	# Accept and keep completing
bindkey -M menuselect '^I' menu-complete		# Tab
bindkey -M menuselect '^[[Z' reverse-menu-complete	# Shift+Tab

# --- vicmd(normal mode) ---
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'U' redo
bindkey -M vicmd 'W' forward-word
bindkey -M vicmd 'B' backward-word
bindkey -M vicmd 'p' vi-put-after             		# Paste

# --- viins(insert mode) ---
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^P' up-line-or-search
bindkey -M viins '^N' down-line-or-search
bindkey -M viins '^L' clear-screen
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^D' delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^[.' insert-last-word	      		# Alt+. insert last word from previous command
bindkey -M viins '^[h' backward-word          		# Alt+h
bindkey -M viins '^[l' forward-word           		# Alt+l

# --- visualmode ---
bindkey -M visual 'y' copy-to-clipboard			# Yank
bindkey -M visual 'd' kill-region             		# Delete

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
