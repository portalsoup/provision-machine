Contents of path/ are script files that should be added to the PATH to be callable
Contents of source/ are bash scripts that should be sourced and resolved immediately by shell

### Provision a machine with ansible
ansible-playbook install.yaml --ask-become-pass

group all content by platform and general

first all platform specific tasks should run, to install software and configure the use of tools
then the general tasks that use tools that should be available across platforms can run

adapt ws command to instead open or attach to an existing tmuxinator workspace at that directory

TODO:
* oh-my-zsh
* update-alternatves
* java
* kotlin
* kscript
* vim configs