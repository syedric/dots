#!/usr/bin/env zsh

# Changing Directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT


# # History Behavior
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/.zhistory"

# Input Output
setopt NO_CLOBBER
setopt CORRECT
setopt NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS
setopt PRINT_EXIT_VALUE
setopt NO_RM_STAR_SILENT
setopt RM_STAR_WAIT

# # Globbing
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt MARK_DIRS
setopt NUMERIC_GLOB_SORT
setopt NO_CASE_GLOB
setopt NO_CASE_MATCH

# Completion
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
setopt LIST_PACKED
setopt LIST_ROWS_FIRST

# Misc Recommended Defaults
setopt NO_BEEP
setopt NO_PROMPT_SP
setopt IGNORE_EOF

stty stop undef
zle_highlight=('paste:none')

ZSH_AUTOSUGGEST_STRATEGY=(completion history)
