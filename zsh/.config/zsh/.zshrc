#!/usr/bin/env zsh

for file in $ZDOTDIR/.zshrc.d/*.(zsh|sh); do
	[ -r "$file" ] && source "$file"
done
