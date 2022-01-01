export WORKSPACE_DIR=$HOME/workspace

compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' wsgh
compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' ws

ws() { cd $WORKSPACE_DIR/$1 }

wsgh() {
  local url="https://github.com/$1/$2"

  local isSharedValid=$(urlStatusCode "$url")
  if [[ $isSharedValid == 200 || $isSharedValid == 302 ]] 
  then
    openFirefoxTab "$url"
  fi
}
