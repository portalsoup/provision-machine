k() {
  kubectl --context="$(ctx kube_context)" "$@"
}

kall() {
  for context in $(kubectl config get-contexts -o name); do
    tput setaf 82
    echo "*** $context ***"
    tput sgr0
    kubectl --context="$context" "$@"
  done
}

_list-kctx() {
  kubectl config get-contexts --output=name
}

kctx() {
  if [[ -z "$1" ]]; then
    _list-kctx
  else
    ctx kube_context "$2"
    k config use-context "$2"
  fi
}

compdef _list-kctx kctx