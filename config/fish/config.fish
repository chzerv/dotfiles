# Disable greeting
set fish_greeting

# PATH
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.node_modules/bin"
fish_add_path "$HOME/.local/bin/"

# Envvars
set -x EDITOR nvim
set -x MANPAGER 'nvim --clean +Man!'
set -x STARSHIP_CONFIG "$HOME/.config/zsh/starship.toml"
set -x npm_config_prefix "$HOME/.node_modules/"

if status is-interactive
    . ~/.config/fish/aliases.fish
    . ~/.config/fish/abbreviations.fish
end
