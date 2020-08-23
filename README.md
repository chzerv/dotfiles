# Personal dotfiles

_These dotfiles work for me, and are not guaranteed to work for other people. Make sure to check the code before using them!_

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
- [alacritty](https://github.com/alacritty/alacritty), a GPU accelerated terminal written in Rust.

_Note_ that Sway etc. are launched using a `systemd` user service.
