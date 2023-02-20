function reboot --description 'alias reboot systemctl reboot'
  systemctl reboot $argv;
end

function mkd --description "Create directory and automatically cd into it"
    mkdir --parents $argv; and cd $argv
end

function mkdtmp --wraps='mkd' --description "Create a directory in /tmp and cd into it"
    mkd /tmp/(date "+%d-%m")
end

function shutdown --wraps='systemctl poweroff' --description 'alias shutdown systemctl poweroff'
  systemctl poweroff $argv;
end

function ls --wraps='ls' --description 'ls with extra flags'
    command ls --color=always --group-directories-first $argv;
end

function exa --wraps='exa' --description 'exa with extra flags'
    command exa --group-directories-first $argv;
end

function tmux --wraps=tmux --description 'alias tmux tmux -2'
    command tmux -2 $argv
end

function def --wraps=translate-shell --description 'Call translate-shell with specific arguments'
    trans :el $argv
end

function explain --wraps=rustc --description 'Call rustc --explain and pipe the output to bat'
    rustc --explain $argv | bat -l rs
end

function k --wraps=kubectl --description 'Alias kubectl to k'
    command kubectl $argv
end

function kubectx --wraps=kubectl --description 'Show Kubernetes contexts, highlighting the current one'
    kubectl config get-contexts | awk '{ if ($1 == "*") { print "\033[32m→ " $2 } else { print $2 } }' | tail -n +2
end
