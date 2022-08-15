function mkdtmp --description "Create a directory in /tmp and cd into it"
    mkd /tmp/(date "+%d-%m")
end
