function mkd --description "Create directory and automatically cd into it"
    mkdir --parents $argv; and cd $argv
end
