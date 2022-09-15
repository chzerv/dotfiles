function :q --wraps=exit --description 'alias :q exit'
    exit $argv;
end

function lg --wraps=lazygit --description 'alias lg lazygit'
  lazygit $argv;
end

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

function l --wraps='ls --color=always --group-directories-first' --description 'alias l ls --color=always --group-directories-first'
  ls --color=always --group-directories-first $argv;
end

function ll --wraps='ls -l --color=always --group-directories-first' --description 'alias ll ls -l --color=always --group-directories-first'
  ls -l --color=always --group-directories-first $argv;
end

function la --wraps='ls -la --color=always --group-directories-first' --description 'alias la ls -la --color=always --group-directories-first'
  ls -la --color=always --group-directories-first $argv;
end

function vi --wraps=nvim --description 'alias vi nvim'
  nvim $argv
end

function tmux --wraps=tmux --description 'alias tmux tmux -2'
    command tmux -2 $argv
end
