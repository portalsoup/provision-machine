export WORKSPACE_DIR=$HOME/workspace

ws() { 
  local orientation=$(ctx default_mux_orientation)
  local workspaceConfig
  if [ -z "$2" ]; then # only 1 arg means no orientation flag, so use store
    echo "using orientation"
    workspaceConfig="workspace-$orientation"
  else
    if [[ "$1" == "-v" ]]; then
      workspaceConfig="workspace-vertical"
    elif [[ "$1" == "-h" ]]
      workspaceConfig="workspace-horizontal"
  fi

  tmuxinator $workspaceConfig $WORKSPACE_DIR/${@: -1} 
}

# Clone to the workspace folder automatically using the glone command
# Then open workspace tmux on the new repo
wsclone() { 
  (cd $WORKSPACE_DIR; gclone "$@")
  ws "${@: -1}"
}

ws-status() { status-bar.kts }

# Which commands get workspace completion
compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' gh
compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' ws