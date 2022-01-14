ctx() {
    local contextLocation=~/.zsh_scripts/context.json
    if [[ -z "$1" ]]; then 
        cat $contextLocation
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