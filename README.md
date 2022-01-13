Contents of path/ are script files that should be added to the PATH to be callable
Contents of source/ are bash scripts that should be sourced and resolved immediately by shell

### Provision a machine with ansible
    ansible-playbook playbook.yaml --ask-become-pass

or to provision remotely:

    ansible-pull -U https://github.com/portalsoup/provision-machine.git -i $(hostname --short) local.yaml --ask-become-pass

group all content by platform and general

first all platform specific tasks should run, to install software and configure the use of tools
then the general tasks that use tools that should be available across platforms can run

TODO:
* oh-my-zsh
* update-alternatves
* java
* kotlin
* kscript
* vim configs
