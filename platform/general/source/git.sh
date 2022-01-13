# Other git related commands can substitue the user or org with this variable for convenience
export GIT_CONTEXT=portalsoup # TODO this needs to be a file so it can be shared between shell sessions dynamically, use with jq maybe to act as a config store

# Get the current context if no args are given, or set the first arg as the new context
gcontext() {
    if [ -z "$1" ]; then
        echo "$GIT_CONTEXT"
        return 0
    fi 
    export GIT_CONTEXT=$1
    
}

# Open a github repo in firefox using the global context based on how many args is given
gh() {
    local url
    if [ "$2" ]; then
        url="https://github.com/$1/$2"
    elif [ "$1" ]; then
        url="https://github.com/$GIT_CONTEXT/$1"
    fi

    local isSharedValid=$(urlStatusCode "$url")
    if [[ $isSharedValid == 200 || $isSharedValid == 302 ]] 
    then
        openFirefoxTab "$url"
    fi
}

# Clones a repo to the current
gclone() {
    if [ "$2" ]; then
        git clone git@github.com:$1/$2.git
    elif [ "$1" ]; then
        git clone git@github.com:$GIT_CONTEXT/$1.git
    fi
}