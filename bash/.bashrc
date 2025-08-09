#!/usr/bin/env bash

# Avoid duplicate sourcing
[[ $- != *i* ]] && return

# Source all files in ~/.bashrc.d
for file in ~/bashrc.d/*.sh; do
	[ -r "$file" ] && source "$file"
done
