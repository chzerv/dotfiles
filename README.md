# Personal dotfiles

- **Operating System**: Mainly [Archlinux](https://www.archlinux.org/), but I also use [Fedora](https://getfedora.org/) on some machines.
- **DE/WM**: GNOME/mutter
- **Editor**: [Doom Emacs](https://github.com/hlissner/doom-emacs) (also [neovim](https://github.com/neovim/neovim), occasionally).
- **Terminal**: [tilix](https://github.com/gnunn1/tilix) (also [alacritty](https://github.com/alacritty/alacritty), occasionally).
- **Shell**: zsh + [zinit](https://github.com/zdharma/zinit) as the package manager + custom config.

Sometimes, I feel like running a tiling Window Manager. For those times, I use:

- [sway](https://github.com/swaywm/sway) as my WM/compositor.
- [mako](https://github.com/emersion/mako) to handle notifications.
- [waybar](https://github.com/Alexays/Waybar), a highly customizable bar for Sway.
- [wofi](https://hg.sr.ht/~scoopta/wofi), a launcher/menu program for wlroots based Wayland compositors.
- [alacritty](https://github.com/alacritty/alacritty), a GPU accelerated terminal written in Rust. I also use [alacritty-colorscheme](https://github.com/toggle-corp/alacritty-colorscheme) to easily change between themes.

_Note_ that Sway etc. are launched using a `systemd` user service.

## Directory Structure

The repository uses a structure similar to a [GNU stow](https://www.gnu.org/software/stow/) managed repository.

- Configs that reside inside `~/.config` are found in `config`.
- Configs that reside inside `~/.local/share` are found in `share`.
- Configs that reside in `~/` are found in the root of the repository.

Aside from that, the `Templates` folder contains some less-important templates for files that I can't seem to remember their syntax.

## Notes

1. **These dotfiles work for me, and are not guaranteed to work for other people. Make sure to check the code before using them!**
2. Many configs include stuff that I've found from all over the internet. I've tried to give credit where credit is due, but I might have missed someone. Sorry!
