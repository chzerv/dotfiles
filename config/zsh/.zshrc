# Load and initialize the completion system {{{
autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $ZDOTDIR/.zcompdump;
else
  compinit -C;
fi;
compdef -d mcd
# }}}

eval "$(navi widget zsh)"

# Prompt {{{
eval "$(starship init zsh)"
# }}}

# Core options {{{

# Use case-insensitive globbing.
unsetopt case_glob

# Also glob dotfiles
setopt globdots

# Use extended globbing
setopt extendedglob

# Automatically change directory if a directory name is entered
setopt autocd

# Allow comments in interactive mode
setopt interactivecomments

# Enable filename expansion for arguments of the form 'anything=expr'
setopt magicequalsubst

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

# }}}

# Completion options {{{
# https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*' menu select

# Enable caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/.zcompcache"

 # Group results
zstyle ':completion:*' group-name ''

# Approximate completions in case you mis-type
zstyle ':completion:*' completer _complete _match _approximate

# Formatting
zstyle ':completion:*' format ' %F{blue}-- %d --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# When doing kill <TAB>, list more options about the processes
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cputime,cmd'
# }}}

#  History Settings {{{{

HISTFILE="$HOME/.cache/zhistory"
HISTSIZE=50000
SAVEHIST=50000

setopt appendhistory
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

# Keybindings {{{
bindkey -e
bindkey "^A" vi-beginning-of-line  # C-A
bindkey "^E"        vi-end-of-line # C-E
# }}}

# Edit in $EDITOR {{{
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
# }}}

# Source stuff {{{

# Functions
for f in $ZDOTDIR/functions/*
do
    [ -f "$f" ] && source "$f"
done

# Aliases
for f in $ZDOTDIR/aliases/*
do
    [ -f "$f" ] && source "$f"
done

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d /usr/share/fzf ]]; then
    if (( $+commands[pacman] )); then
        source /usr/share/fzf/key-bindings.zsh
    elif (( $+commands[dnf] )); then
        source /usr/share/fzf/shell/key-bindings.zsh
    fi
fi

# command-not-found utility
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi
# }}}

# Zinit {{{
[ -f "$ZDOTDIR/zinit.zsh" ] && source "$ZDOTDIR/zinit.zsh"
# }}}
