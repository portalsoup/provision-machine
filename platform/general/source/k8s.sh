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
    kubectl config get-contexts --output=name
  else
    ctx kube_context "$1"
    kubectl config use-context "$1"
  fi
}

# k8s completions

list-kctx() {
  kubectl config get-contexts --output=name
}

_kctx_completion() {
  _values $(list-kctx)
}


compdef _kctx_completion kctx