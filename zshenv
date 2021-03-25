path=(
  $HOME/.local/bin/scripts
  $HOME/.local/bin/scripts/fzf_scripts
  /var/lib/flatpak/exports/bin
  $HOME/.cargo/bin
  $HOME/.node_modules/bin
  $path)

ZDOTDIR=$HOME/.config/zsh

################## zsh-autosuggestions {{{

# Highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,bg=none,underline"
HISTORY_SUBSTRING_SEARCH_FUZZY=set

# Don't trigger autosuggestions on too large strings (usually from copy/pasting)
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

# Autosuggestions ignore history entries longer than 50 characters
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"

# Enable async mode
ZSH_AUTOSUGGEST_USE_ASYNC=1
# }}}

# Runtime env vars {{{
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="gnome-terminal"
export BROWSER="firefox"
export READER="evince"
export MANPAGER="nvim -c 'set ft=man' -"
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
export npm_config_prefix=~/.node_modules
export WORKON_HOME=~/.virtualenvs
export CHROOT=/media/General/Builds
# }}}

# Fix Firefox remote protocol on mixed Wayland/X11 environments.
# Fixes the "Firefox is already runnin" error due to locked Firefox profile.
# Requires Firefox 74+
export MOZ_DBUS_REMOTE=1

# FZF Setup {{{
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --hidden --follow --exclude ".git --type d"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -i -selection clipboard)+abort' --header '?:preview C-y:copy'"

export FZF_DEFAULT_OPTS="
--ansi
--reverse
--info=inline
--height=80%
--multi
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--preview-window right:70%
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind 'ctrl-v:execute(emacs {+})'
--bind 'alt-k:preview-up,alt-p:preview-up'
--bind 'alt-j:preview-down,alt-n:preview-down'
--bind 'alt-w:toggle-preview-wrap'
"
# }}}
