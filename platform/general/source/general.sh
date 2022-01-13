### Completions ###
# General
zstyle ':completion:*' completer _extensions _complete _approximate _expand
zstyle ':completion:*' file-list all 
zstyle ':completion:*:cd:*:default' list-colors ${(s.:.)LS_COLORS}

update-provision() {
  ansible-pull -U https://github.com/portalsoup/provision-machine.git -i $(hostname --short) local.yml --ask-become-pass
}

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

watcher() {
  local time=$1
  local file=/tmp/watcher$$.txt
  local height=0
  shift
  while true; do
    height=$(($LINES - 5))
    ( eval $* ) | tail -n ${height} > ${file} 2>/dev/null
    clear
    cat ${file}
    \rm -f "${file}"
    sleep ${time}
  done
}

hideCursor() {
  tput civis
}

showCursor() {
  tput cnorm
}