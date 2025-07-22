#!/usr/bin/env zsh

# Interactive Shell Behavior
setopt AUTO_CD
setopt CDABLE_VARS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# History Behavior
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
HISTSIZE=10000
SAVEHIST=10000

# Globbing & Completion
setopt EXTENDED_GLOB
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt MENU_COMPLETE

# Safety & Sanity
setopt NO_CLOBBER
setopt RM_STAR_SILENT
setopt NO_FLOW_CONTROL

# Scripting & Function Scope
setopt ERR_EXIT
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS

# Misc Recommended Defaults
unsetopt BEEP
unsetopt PROMPT_CR
