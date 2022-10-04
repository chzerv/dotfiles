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

function mpv --description "Run mpv with specific flags"
    set ytdlp_path (which yt-dlp)

    command mpv --hwdec=vaapi --script-opts=ytdl_hook-ytdl_path=$ytdlp_path $argv
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
