path=(
  $HOME/.local/bin
  /var/lib/flatpak/exports/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  /usr/local/bin/go/bin
  $HOME/.node_modules/bin
  $path)

ZDOTDIR=$HOME/.config/zsh

##### XDG Base Directory {{{
# User-specific configurations, analogous to /etc
export XDG_CONFIG_HOME="${HOME}/.config"
# User-specific cached data, analogous to /var/cache
export XDG_CACHE_HOME="${HOME}/.cache"
# User-specific data files, analogous to /usr/share
export XDG_DATA_HOME="${HOME}/.local/share"
# User-specific state files, analogous to /var/lib
export XDG_STATE_HOME="${HOME}/.local/state"
# }}}

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
export TERMINAL="konsole"
export BROWSER="firefox"
export READER="evince"
export MANPAGER='nvim --clean +Man!'
export CHROOT=/media/General/Builds
export STARSHIP_CONFIG=~/.config/zsh/starship.toml
export npm_config_prefix="$HOME/.node_modules/"
# }}}

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
