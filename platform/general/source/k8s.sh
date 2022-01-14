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

kctx() {
  if [[ -z "$1" ]]; then
    _list-kctx
  else
    ctx kube_context "$1"
    kubectl config use-context "$1"
  fi
}

# k8s completions

_list-kctx() {
  _values $(kubectl config get-contexts --output=name)
}


compdef _list-kctx kctx