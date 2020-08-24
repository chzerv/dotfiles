# Personal dotfiles

[![Made with Doom Emacs](https://img.shields.io/badge/Made_with-Doom_Emacs-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)](https://github.com/hlissner/doom-emacs)
[![Archlinux](https://img.shields.io/badge/arch-linux-blue.svg?style=flat-square&logo=Arch-Linux&logoColor=white)](https://archlinux.org)
[![Fedora](https://img.shields.io/badge/Fedora-v32-blue.svg?style=flat-square&logo=Fedora&logoColor=white&)](https://getfedora.org)
[![Ansible](https://img.shields.io/badge/Ansible-Managed-blue.svg?style=flat-square&logo=Ansible&logoColor=white&labelColor=red&color=black)](https://github.com/ansible/ansible)

This repository is a place for my personal Linux dotfiles. It uses a structure similar to a [GNU stow](https://www.gnu.org/software/stow/) managed repository, but not quite.

- Configs that reside inside `~/.config` are found in `config`.
- Configs that reside inside `~/.local/share` are found in `share`.
- Configs that reside in `~/` are found in the root of the repository.

Aside from that, the `Templates` folder contains some less-important templates for files that I can't seem to remember their syntax.

To easily deploy them in my machines I use [Ansible](https://github.com/ansible/ansible), and specifically my [linux-workstation-playbook](https://github.com/chzerv/linux-workstation-playbook.git).

---

**System info:**

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

## How to use

### The Ansible way

**NOTE:** After running the code below, my dotfiles will be symlinked to their respective places. Please, make sure you've read through my dotfiles and know what you're doing before proceeding.

1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. Clone my [linux-workstation-playbook](https://github.com/chzerv/linux-workstation-playbook.git) and `cd` into it:

   ```sh
   git clone https://github.com/chzerv/linux-workstation-playbook.git && cd linux-workstation-playbook
   ```

3. Run my Ansible playbook, with the `--tag=dotfiles` option:

   ```sh
   ansible-playbook -i inventory main.yml --tag=dotfiles
   ```

   After a couple of minutes everything should be setup, except what's listed in [this section](https://github.com/chzerv/linux-workstation-playbook#stuff-that-still-have-to-be-done-manually).

### The standard way

1. Clone this repository:

   ```sh
   git clone https://github.com/chzerv/dotfiles.git
   ```

2. Copy/symlink whatever you need.

## Notes

1. **These dotfiles work for me, and are not guaranteed to work for other people. Make sure to check the code before using them!**
2. Many configs include stuff that I've found from all over the internet. I've tried to give credit where credit is due, but I might have missed someone. Sorry!
