k() {
  context=$(ctx kube_context)
  namespace=$(ctx kube_namespace)

  if ! ctx kube_namespace </dev/null > /dev/null 2>&1; then
    echo "no namespace"
    kubectl --context="$(ctx kube_context)" -n="$(ctx kube_namespace)" "$@"
  else
    echo "namespace"
    kubectl --context="$(ctx kube_context)" "$@"
  fi
}

kname() {
  k -n "$(ctx kube_namespace)" "$@"
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
_kctx_completion() {
  _values $(kctx)
}

compdef _kctx_completion kctx