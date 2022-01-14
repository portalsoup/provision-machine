k() {
  context=$(ctx kube_context)
  namespace=$(ctx kube_namespace)

  contextArg=
  if [[ "$context" ]]; then
    contextArg="--context=$context"
  else
    echo "kube_context is not set"
  fi

  namespaceArg=
  if [[ "$namespace" ]]; then
    contextArg="-n=$namespace"
  else
    echo "kube_namespace is not set"
  fi

  kubectl "$contextArg $namespaceArg" "$@"
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