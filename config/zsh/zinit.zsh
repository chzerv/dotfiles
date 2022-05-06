ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "${ZINIT_HOME}" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)" && \
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Every plugin is turbo loaded (wait'')
# lucid just supresses the output of each plugin
# light disables reporting

# forgit - https://github.com/wfxr/forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# LS_COLORS
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# zsh-bd - https://github.com/Tarrasch/zsh-bd
zinit ice wait lucid
zinit light tarrasch/zsh-bd

zinit ice wait lucid
zinit light skywind3000/z.lua

# zinit ice depth'1'
# zinit light romkatv/powerlevel10k

# zsh-history-substring-search - https://github.com/zsh-users/zsh-history-substring-search
zinit wait lucid atload"bindkey '^[[A' history-substring-search-up;
    bindkey '^[[B' history-substring-search-down" for \
        zsh-users/zsh-history-substring-search

# Bunch of OMG plugins & completions
# docker and docker-compose completions
# rustc and cargo completions
# OMG's git library and plugin
zinit wait lucid light-mode for \
    as"completion" \
        OMZ::plugins/docker/_docker \
    as"completion" \
        OMZ::plugins/docker-compose/_docker-compose \
    as"completion" \
        OMZ::plugins/extract/extract.plugin.zsh \

# Delete completions up to this point
zinit cdclear -q

# zsh-autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
# zsh-completions - https://github.com/zsh-users/zsh-completions
# f-sy-h - https://github.com/zdharma-continuum/fast-syntax-highlighting.git

# Suggestions uses 'precmd' hook, which is being called right after loading zshrc.
# because precmd hooks are called before displaying the prompt, we add the
# 'atload"_zsh_autosuggest_start"', which calls the same function the hook 
# would call right after loading autosuggestions, resulting in exactly
# the same behavior.

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
