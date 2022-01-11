Contents of path/ are script files that should be added to the PATH to be callable
Contents of source/ are bash scripts that should be sourced and resolved immediately by shell

# ~/.zshrc

# Export script dir
ZSH_USER_SCRIPTS=~/.zsh_scripts

# Add to PATH
export PATH=$ZSH_USER_SCRIPTS/path:$PATH


### Source scripts
for file in $ZSH_USER_SCRIPTS/source/**/*.sh; do
  source "$file"
done

### Install via ansible
ansible-playbook install.yaml --ask-become-pass

TODO:
* oh-my-zsh