#!/usr/bin/env zsh

for file in $ZDOTDIR/.zshrc.d/*.(zsh|sh); do
	[ -r "$file" ] && source "$file"
done

# Autocomplete
# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Syntax Highlighting
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fish like autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fast Syntax Highlighting
source /usr/share/zsh/plugins/fsh/fast-syntax-highlighting.plugin.zsh
