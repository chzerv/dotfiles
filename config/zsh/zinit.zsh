if [ ! -d "${HOME}/.zinit" ]; then
    mkdir -p "${HOME}/.zinit" && \
         git clone "https://github.com/zdharma/zinit.git ~/.zinit/bin"
fi

source "${HOME}/.zinit/bin/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Every plugin is turbo loaded (wait'')
# lucid just supresses the output of each plugin
# light disables reporting

# forgit - https://github.com/wfxr/forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# zsh-autopair - https://github.com/hlissner/zsh-autopair
#zinit ice wait lucid
#zinit load hlissner/zsh-autopair

# zsh-bd - https://github.com/Tarrasch/zsh-bd
zinit ice wait lucid
zinit light tarrasch/zsh-bd

# zsh-k - https://github.com/supercrabtree/k
#zinit ice wait lucid
#zinit light supercrabtree/k

# powerlevel10k - https://github.com/romkatv/powerlevel10k
zinit ice depth'1'
zinit light romkatv/powerlevel10k

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
        OMZ::plugins/extract/extract.plugin.zsh \
    as"completion" \
        OMZ::plugins/cargo/_cargo \
    as"completion" \
        OMZ::plugins/rust/_rust

# Delete completions up to this point
zinit cdclear -q

# zsh-autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
# zsh-completions - https://github.com/zsh-users/zsh-completions
# f-sy-h - https://github.com/zdharma/fast-syntax-highlighting

# Suggestions uses 'precmd' hook, which is being called right after loading zshrc.
# because precmd hooks are called before displaying the prompt, we add the
# 'atload"_zsh_autosuggest_start"', which calls the same function the hook 
# would call right after loading autosuggestions, resulting in exactly
# the same behavior.

zinit wait lucid light-mode for \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
