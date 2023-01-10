# Disable greeting
set fish_greeting

# PATH
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.node_modules/bin"
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.local/bin/scripts/"
fish_add_path "$HOME/.local/bin/distrobox/bin"
fish_add_path "/usr/local/bin/go/bin"

# Envvars
set -x EDITOR nvim
set -x MANPAGER 'nvim --clean +Man!'
set -x STARSHIP_CONFIG "$HOME/.config/starship.toml"
set -x npm_config_prefix "$HOME/.node_modules/"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep.conf"
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

if status is-interactive

    # Starship prompt
    starship init fish | source

    # Navi
    navi widget fish | source

    # Source abbreviations
    . ~/.config/fish/abbreviations.fish

    # Source functions
    . ~/.config/fish/functions.fish

    # https://github.com/PatrickF1/fzf.fish
    set fzf_dir_opts --bind "ctrl-e:execute(nvim {} &> /dev/tty)"

    zoxide init fish | source
end
