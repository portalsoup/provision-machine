### Completions ###
# General
zstyle ':completion:*' completer _extensions _complete _approximate _expand
zstyle ':completion:*' file-list all 
zstyle ':completion:*:cd:*:default' list-colors ${(s.:.)LS_COLORS}

cdl() {
  cd "$1"
  ls
}

cdll() {
  cd "$1"
  ll
}

urlStatusCode() { curl --write-out '%{http_code}' --silent --output /dev/null $1 }

ggrep() { git grep $@ }

