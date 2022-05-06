# Personal dotfiles

[![Archlinux](https://img.shields.io/badge/arch-linux-blue.svg?style=flat-square&logo=Arch-Linux&logoColor=white)](https://archlinux.org)
[![Fedora](https://img.shields.io/badge/Fedora-latest-blue.svg?style=flat-square&logo=Fedora&logoColor=white&)](https://getfedora.org)
[![Ansible](https://img.shields.io/badge/Ansible-Managed-blue.svg?style=flat-square&logo=Ansible&logoColor=white&labelColor=red&color=black)](https://github.com/ansible/ansible)

This repository is a place for my personal Linux dotfiles. It uses a structure similar to a [GNU stow](https://www.gnu.org/software/stow/) managed repository, but not quite.

- Configs that reside inside `~/.config` are found in `config`.
- Configs that reside inside `~/.local/share` are found in `share`.
- Configs that reside in `~/` are found in the root of the repository.

To easily deploy them in my machines I use [Ansible](https://github.com/ansible/ansible), and specifically my [workstation-setup](https://github.com/chzerv/workstation-setup) playbook.

---

**System info:**

- **Operating System**: [Archlinux](https://www.archlinux.org/) and/or [Fedora](https://getfedora.org/).
- **DE**: GNOME on laptops, KDE Plasma on the desktop
- **Editor**: [neovim](https://github.com/neovim/neovim)
- **Terminal**: The default + `tmux`
- **Shell**: zsh + [zinit](https://github.com/zdharma-continuum/zinit) as the package manager + custom config.

## How to use

### The Ansible way

**NOTE:** After running the code below, my dotfiles will be symlinked to their respective places. Please, make sure you've read through my dotfiles and know what you're doing before proceeding.

1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. Clone my [workstation-setup](https://github.com/chzerv/workstation-setup) playbook and `cd` into it:

   ```sh
   git clone https://github.com/chzerv/workstation-setup.git && cd workstation-setup
   ```

3. Create an `inventory` file and add your host(s):
    ```ini
    [myhost]
    10.10.10.10

    [myhost:vars]
    ansible_user=user
    ansible_ssh_port=2222
    ansible_private_key_file=~/.ssh/priv_key
    ```

4. Run my Ansible playbook, with the `--tag=dotfiles` option:

   ```sh
   ansible-playbook -i inventory main.yml --tag=dotfiles
   ```

After a couple of minutes everything should be setup, except what's listed in [this section](https://github.com/chzerv/workstation-setup#staff-that-still-have-to-be-done-manually=).

### The standard way

1. Clone this repository:

   ```sh
   git clone https://github.com/chzerv/dotfiles.git
   ```

2. Copy/symlink whatever you need.

## Notes

1. **These dotfiles work for me, and are not guaranteed to work for other people. Make sure to check the code before using them!**
2. Many configs include stuff that I've found from all over the internet. I've tried to give credit where credit is due, but I might have missed someone. Sorry!
