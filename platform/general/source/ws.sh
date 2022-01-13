export WORKSPACE_DIR=$HOME/workspace

compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' wsgh
compdef '_files -W "$WORKSPACE_DIR" -/ -g "$WORKSPACE_DIR/*"' ws

ws() { 
  local workspaceConfig
  if [ -z "$2" ]; then
    workspaceConfig="workspace-vertical"
  else
    if [[ "$1" == "-v" ]]; then
      workspaceConfig="workspace-vertical"
    elif [[ "$1" == "-h" ]]
      workspaceConfig="workspace-horizontal"
  fi

  tmuxinator $workspaceConfig $WORKSPACE_DIR/${@: -1} 
}

# Add workspace completion to the gh command
wsgh() { gh $1 }

# Clone to the workspace folder automatically using the glone command
# Then open workspace tmux on the new repo
wsclone() { 
  (cd $WORKSPACE_DIR; gclone $1)
  ws $1 
}