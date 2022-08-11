#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-
#
# fish-completion for distrobox
# https://github.com/89luca89/distrobox
#

# Available distrobox commands
set -l commands create enter list stop rm version

# Disable file completions
complete -c distrobox --no-files

complete -c distrobox -n "not __fish_seen_subcommand_from $commands" \
    -a "create enter list stop rm version"

complete -c distrobox -s enter --description "Enter a container"
complete -c distrobox -s list --description "List available containers"

function __fish_distrobox_complete_containers
    distrobox list | awk '{ print $4 }' | tail -n +2
end

function __fish_distrobox_complete_running_containers
    set -l active_containers (distrobox list | grep -vi exited | awk '{ print $4 }' | tail -n +2)

    string join \n $active_containers
end

# List available containers when using `distrobox enter/rm`
complete -c distrobox -n "__fish_seen_subcommand_from enter" -a '(__fish_distrobox_complete_containers)'

complete -c distrobox -n "__fish_seen_subcommand_from rm" -a '(__fish_distrobox_complete_containers)'

# List running containers when using `distrobox stop`
complete -c distrobox -n "__fish_seen_subcommand_from stop" -a '(__fish_distrobox_complete_running_containers)'
