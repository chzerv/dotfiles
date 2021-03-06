###########################################################{{{
# # Load and initialize the completion system ignoring insecure directories with a
# # cache time of 20 hours, so it should almost always regenerate the first time a
# # shell is opened each day.
autoload -Uz compinit promptinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files
# promptinit
# setopt prompt_subst
###########################################################}}}

###########################################################
# Set options

# Use case-insensitive globbing.
unsetopt case_glob
# Also glob dotfiles
setopt globdots
# Use extended globbing
setopt extendedglob

# Automatically change directory if a directory name is entered
setopt autocd

# Smart URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Allow brace character class list expansion
setopt brace_ccl
# Combine zero-length punctuation characters (accents) with the base character.
setopt combining_chars
# Allow "Henry's Garage" instead of "Henry'\'s Garage".
setopt rc_quotes

# List jobs in the long format by default.
setopt long_list_jobs

# Attempt to resume existing job before creating a new process.
setopt auto_resume

# Report status of background jobs immediately.
setopt notify

# Don't run all background jobs at a lower priority.
unsetopt bg_nice

# Don't kill jobs on shell exit.
# unsetopt hup

# Turn on corrections.
setopt correct

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Complete from both ends of a word.
setopt complete_in_word

# Move the cursor to the end of a completed word.
setopt always_to_end

# Perform path search even on command names with slashes.
setopt path_dirs

# Show completion menu on successive tab press.
setopt auto_menu

# Automatically list choice on ambiguous completion.
setopt auto_list

# If completed parameter is a directory, add a trailing slash.
setopt auto_param_slash

# Treat words like bash does, e.g., when we have a path like
# /foo/bar and C-w is pressed, delete only "bar".
autoload -U select-word-style
select-word-style bash

#  Zstyle {{{{
zstyle ':completion:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
# zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' list-colors dircolors
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true
# }}}}

#  History Settings {{{{
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory notify
unsetopt beep nomatch
# Treat the '!' character specially during expansion.
setopt bang_hist
# Write to the history file immediately, not when the shell exits.
setopt inc_append_history
# Share history between all sessions.
setopt share_history
# Expire a duplicate event first when trimming history.
setopt hist_expire_dups_first
# Do not record an event that was just recorded again.
setopt hist_ignore_dups
# Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_all_dups
# Do not display a previously found event.
setopt hist_find_no_dups
# Do not record an event starting with a space.
setopt hist_ignore_space
# Do not write a duplicate event to the history file.
setopt hist_save_no_dups
# Do not execute immediately upon history expansion.
setopt hist_verify
# Show timestamp in history
setopt extended_history
# }}}}

# Set keybindings
bindkey -e
bindkey "^A" vi-beginning-of-line  # C-A
bindkey "^E"        vi-end-of-line # C-E

# Allow command line editing in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Source zsh functions.
for f in $ZDOTDIR/functions/*
do
    [ -f "$f" ] && source "$f"
done

# Source zsh aliases.
for f in $ZDOTDIR/aliases/*
do
    [ -f "$f" ] && source "$f"
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d /usr/share/fzf ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

source /usr/bin/virtualenvwrapper_lazy.sh

eval "$(fasd --init auto)"
[ -f "$ZDOTDIR/clrs.zsh" ] && source "$ZDOTDIR/clrs.zsh"
source <(echo "$(navi widget zsh)")

###########################################################

# ZINIT

###########################################################

[ -f "$ZDOTDIR/zinit.zsh" ] && source "$ZDOTDIR/zinit.zsh"
