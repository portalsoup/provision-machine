ctx() {
    local contextLocation=~/.zsh_scripts/context.json
    if [[ -z "$2" ]]; then
        jq -r ."$1" $contextLocation
        return 0
    fi 

    if [[ "$1" && "$2" ]]; then
        ctx-write-value.kts $1 $2
    fi
}

gctx() { ctx git_content $1 }