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
  if [[ "$1" == "get" ]]; then
    k config get-contexts
  elif [[ "$1" == "switch" ]]; then
    k config use-context "$2"
  fi
}