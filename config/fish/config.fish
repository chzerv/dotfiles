# Disable greeting
set fish_greeting

# PATH
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.node_modules/bin"
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.local/bin/scripts/"
fish_add_path "/usr/local/bin/go/bin"

# Envvars
set -x EDITOR nvim
set -x MANPAGER 'nvim --clean +Man!'
set -x STARSHIP_CONFIG "$HOME/.config/zsh/starship.toml"
set -x npm_config_prefix "$HOME/.node_modules/"

if status is-interactive
    starship init fish | source
    navi widget fish | source
    . ~/.config/fish/abbreviations.fish

    # https://github.com/PatrickF1/fzf.fish
    set fzf_dir_opts --bind "ctrl-e:execute(nvim {} &> /dev/tty)"
end
