# Easier navigation {{{
alias d=" dirs -v"
# }}}

# Shortcuts {{{
alias grep='grep --color=always'
alias egrep='egrep --colour=auto'
alias ls=' ls --color=always'
alias la=' ls -A --group-directories-first --color=always'
alias l=' ls -C --group-directories-first --color=always'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias sleep='systemctl suspend'
alias hibernate='systemctl hibernate'
alias vi="nvim"
alias :q="exit"
alias open="xdg-open"
alias md="mkdir -pv"
alias ka="killall"
alias szrc=" source $ZDOTDIR/.zshrc"
alias oo="hohup xdg-open . > /dev/null &"
alias tmux="tmux -2"
alias rg="rg -i"
alias cp="cp -r"
alias trash="trash-put"

# Edit specific files
alias cf-z="$EDITOR $ZDOTDIR/.zshrc; source $ZDOTDIR/.zshrc; echo 'Reloaded .zshrc..'"

# Quickly move into specific directories
alias notes="cd ${HOME}/Documents/Syncthing/Notes"
alias docs="cd ${HOME}/Documents"
alias dot="cd ${HOME}/Downloads"

# youtube-dl
alias yt="youtube-dl --add-metadata -ic"
alias yta="youtube-dl --add-metadata --extract-audio --audio-format mp3"
# }}}

# Safety nets {{{
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# }}}

# Print a horizontal ruler
alias hr=' tput setaf 3; for i in $(seq 1 $COLUMNS); do printf '='; done; tput sgr0'
# }}}
