# Open a github repo in firefox using the global context based on how many args is given
gh() {
    local url
    if [ "$2" ]; then
        url="https://$(ctx git_host)/$1/$2"
    elif [ "$1" ]; then
        url="https://$(ctx git_host)/$(ctx git_context)/$1"
    fi

    local isSharedValid=$(urlStatusCode "$url")
    if [[ $isSharedValid == 200 || $isSharedValid == 302 ]]; then
        openFirefoxTab "$url"
    else
        echo "Invalid repository"
    fi
}

# Clones a repo to the current
gclone() {
    if [ "$2" ]; then
        git clone "git@$(ctx git_host):$1/$2.git"
    elif [ "$1" ]; then
        git clone "git@$(ctx git_host):$(ctx git_context)/$1.git"
    fi
}