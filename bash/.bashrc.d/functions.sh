#!/usr/bin/env bash

mkcd() {
	mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "Unknown format: $1" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


reload() {
  source ~/.bashrc && echo "Shell reloaded!"
}

fsearch() {
  grep -rnw '.' -e "$1"
}

fsearch() {
  grep -rnw '.' -e "$1"
}

biggest() {
  du -ah . | sort -rh | head -n ${1:-10}
}

copy_path() {
  pwd | tr -d '\n' | pbcopy
  echo "Copied path: $(pwd)"
}

count_ext() {
  find . -type f | sed -n 's/..*\.//p' | sort | uniq -c | sort -nr
}

port_check() {
  lsof -i :$1
}

slink() {
  if [ -e "$2" ]; then
    mv "$2" "$2.bak"
    echo "Backed up $2 to $2.bak"
  fi
  ln -s "$1" "$2"
}

myip() {
  curl -s https://api.ipify.org
}

please() {
  sudo $(fc -ln -1)
}

