# Disable greeting
set fish_greeting

# PATH
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.node_modules/bin"
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.local/bin/scripts"

# Envvars
set -x EDITOR nvim
set -x MANPAGER 'nvim --clean +Man!'
set -x STARSHIP_CONFIG "$HOME/.config/zsh/starship.toml"
set -x npm_config_prefix "$HOME/.node_modules/"

if status is-interactive
    # starship init fish | source
    alias vi="nvim"
    alias :q="exit"
    alias l="ls --color=always --group-directories-first"
    alias ll="ls -l --color=always --group-directories-first"
    alias la="ls -la --color=always --group-directories-first"
    alias lg="lazygit"
end
