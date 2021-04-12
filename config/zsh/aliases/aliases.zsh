# Easier navigation {{{
alias d=" dirs -v"
# }}}

# Shortcuts {{{
alias grep='grep --color=always'
alias egrep='egrep --colour=auto'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias sleep='systemctl suspend'
alias hibernate='systemctl hibernate'
alias vi="nvim"
alias :q="exit"
alias open="xdg-open"
alias cf-z="$EDITOR $ZDOTDIR/.zshrc"
alias md="mkdir -pv"
alias ka="killall"
alias szrc=" source $ZDOTDIR/.zshrc"
alias oo="hohup xdg-open . > /dev/null &"
alias tmux="tmux -2"
alias rg="rg -i"
alias emt="emacsclient -a '' -t"
alias cp="cp -r"
alias trash="trash-put"

# youtube-dl
alias yt="youtube-dl --add-metadata -ic"
alias yta="youtube-dl --add-metadata --extract-audio --audio-format mp3"
# }}}

# Pretty ls {{{
alias ls=' ls --color=always'
alias la=' ls -A --group-directories-first --color=always'
alias l=' ls -C --group-directories-first --color=always'
alias ll="exa -lF"
alias lla=" exa -alF"
alias llg="exa -alF|ag"
# }}}

# Gzip-enabled 'curl'
alias curl="curl -L --compressed"

# Safety nets {{{
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# }}}

alias -g bg="& disown"
# Horizontal ruler
alias hr=' tput setaf 3; for i in $(seq 1 $COLUMNS); do printf '='; done; tput sgr0'
# }}}
