ctx() {
    local contextLocation=~/.zsh_scripts/context.json
    if [[ -z "$1" ]]; then 
        jq . $contextLocation
    elif [[ -z "$2" ]]; then
        if jq -e -r ."$1" $contextLocation </dev/null > /dev/null 2>&1; then
             jq -r ."$1" $contextLocation
        else
            echo ""
            return 1
        fi
    elif [[ "$1" && "$2" ]]; then
        ctx-write-value.kts $1 $2
    fi
}

# add completion for ctx by maintaining a list of properties

# k8s completions
_ctx_completion() {
    possibleValues=(
        "git_context"
        "git_host"
        "default_mux_orientation"
        "kube_context"
        "kube_namespace"
    )
    _values -s ' ' $possibleValues
}

compdef _ctx_completion ctx